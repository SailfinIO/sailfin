#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef char *SailfinString;
typedef void *SailfinValue;

typedef struct
{
    SailfinValue *data;
    int64_t length;
} SailfinArray;

static SailfinString sailfin_empty_string(void)
{
    static char empty_buffer[1] = {'\0'};
    return empty_buffer;
}

static SailfinString alloc_string(int64_t length)
{
    if (length < 0)
    {
        length = 0;
    }
    size_t size = (size_t)length + 1;
    char *buffer = malloc(size);
    if (!buffer)
    {
        return sailfin_empty_string();
    }
    memset(buffer, 0, size);
    return buffer;
}

static SailfinString string_from_span(const char *data, int64_t length)
{
    SailfinString value = alloc_string(length);
    if (value == sailfin_empty_string())
    {
        return value;
    }
    if (data && length > 0)
    {
        memcpy(value, data, (size_t)length);
    }
    return value;
}

static SailfinString string_from_cstr(const char *value)
{
    if (!value)
    {
        return alloc_string(0);
    }
    return string_from_span(value, (int64_t)strlen(value));
}

static SailfinString string_clone(void *value_ptr)
{
    if (!value_ptr)
    {
        return alloc_string(0);
    }
    const char *raw = (const char *)value_ptr;
    return string_from_span(raw, (int64_t)strlen(raw));
}

static const char *string_data(void *value_ptr)
{
    if (!value_ptr)
    {
        return "";
    }
    return (const char *)value_ptr;
}

static int64_t string_length(void *value_ptr)
{
    if (!value_ptr)
    {
        return 0;
    }
    return (int64_t)strlen((const char *)value_ptr);
}

static SailfinArray *alloc_array(int64_t length)
{
    if (length < 0)
    {
        length = 0;
    }
    SailfinArray *array = malloc(sizeof(SailfinArray));
    if (!array)
    {
        return NULL;
    }
    array->length = length;
    array->data = length > 0 ? calloc((size_t)length, sizeof(SailfinValue)) : NULL;
    return array;
}

void sailfin_runtime_bounds_check(int64_t index, int64_t length)
{
    if (index < 0 || index >= length)
    {
        fprintf(stderr, "[stage2-runtime] bounds check failed (index=%lld, length=%lld)\n",
                (long long)index, (long long)length);
        abort();
    }
}

int64_t sailfin_runtime_string_length(SailfinString value)
{
    int64_t length = string_length(value);
    static int debug_length_count = 0;
    if (debug_length_count < 200)
    {
        const char *text = string_data(value);
        int preview = 0;
        if (text)
        {
            preview = (int)length;
            if (preview > 40)
            {
                preview = 40;
            }
        }
        fprintf(stderr,
                "[stage2-debug] string_length ptr=%p len=%lld preview=\"%.*s\"\n",
                (void *)value,
                (long long)length,
                preview,
                text ? text : "");
    }
    debug_length_count++;
    return length;
}

void *sailfin_runtime_string_concat(SailfinString a, SailfinString b)
{
    int64_t len_a = string_length(a);
    int64_t len_b = string_length(b);
    SailfinString result = alloc_string(len_a + len_b);
    if (result == sailfin_empty_string())
    {
        return result;
    }
    if (len_a > 0)
    {
        memcpy(result, string_data(a), (size_t)len_a);
    }
    if (len_b > 0)
    {
        memcpy(result + len_a, string_data(b), (size_t)len_b);
    }
    result[len_a + len_b] = '\0';
    return result;
}

void *sailfin_runtime_substring(SailfinString value, int64_t start, int64_t end)
{
    int64_t length = string_length(value);
    if (start < 0)
    {
        start = 0;
    }
    if (end < start)
    {
        end = start;
    }
    if (end > length)
    {
        end = length;
    }
    int64_t span = end - start;
    const char *data = string_data(value);
    return string_from_span(data ? data + start : NULL, span);
}

double sailfin_runtime_grapheme_count(SailfinString value)
{
    return (double)string_length(value);
}

void *sailfin_runtime_grapheme_at(SailfinString value, double index)
{
    int64_t idx = (int64_t)index;
    const char *data = string_data(value);
    int64_t length = string_length(value);
    if (!data || idx < 0 || idx >= length)
    {
        return alloc_string(0);
    }
    char buffer[5] = {0};
    buffer[0] = data[idx];
    return string_from_span(buffer, 1);
}

bool sailfin_runtime_is_decimal_digit(int8_t ch)
{
    return ch >= '0' && ch <= '9';
}

bool sailfin_runtime_is_whitespace_char(int8_t ch)
{
    return ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r';
}

bool sailfin_runtime_is_number(SailfinString value)
{
    const char *text = string_data(value);
    if (!text || *text == '\0')
    {
        return false;
    }
    char *end = NULL;
    strtod(text, &end);
    return end && *end == '\0';
}

bool sailfin_runtime_is_string(SailfinString value)
{
    (void)value;
    return true;
}

bool sailfin_runtime_is_boolean(SailfinString value)
{
    const char *text = string_data(value);
    if (!text)
    {
        return false;
    }
    return strcmp(text, "true") == 0 || strcmp(text, "false") == 0;
}

bool sailfin_runtime_is_array(void *value)
{
    (void)value;
    return false;
}

bool sailfin_runtime_is_void(void *value)
{
    return value == NULL;
}

bool sailfin_runtime_is_callable(void *value)
{
    (void)value;
    return false;
}

bool sailfin_runtime_instance_of(void *value, void *type_name)
{
    (void)value;
    (void)type_name;
    return false;
}

SailfinArray *sailfin_runtime_append_string(SailfinArray *array, SailfinString value)
{
    if (!array)
    {
        return NULL;
    }
    static int debug_append_count = 0;
    static const int append_debug_limit = 200;
    if (debug_append_count < append_debug_limit)
    {
        fprintf(stderr,
                "[stage2-debug] append_string array=%p len=%lld value=%p span=%lld\n",
                (void *)array,
                (long long)array->length,
                (void *)value,
                (long long)string_length(value));
        const char *text = string_data(value);
        if (text)
        {
            int64_t printable = string_length(value);
            if (printable > 64)
            {
                printable = 64;
            }
            fprintf(stderr,
                    "[stage2-debug] append_string value_prefix=\"%.*s\"\n",
                    (int)printable,
                    text);
        }
        fflush(stderr);
    }
    debug_append_count++;
    int64_t new_length = array->length + 1;
    SailfinValue *new_data = realloc(array->data, (size_t)new_length * sizeof(SailfinValue));
    if (!new_data)
    {
        return array;
    }
    new_data[array->length] = string_clone(value);
    array->data = new_data;
    array->length = new_length;
    return array;
}

SailfinArray *sailfin_runtime_concat(SailfinArray *lhs, SailfinArray *rhs)
{
    int64_t lhs_len = lhs ? lhs->length : 0;
    int64_t rhs_len = rhs ? rhs->length : 0;
    SailfinArray *result = alloc_array(lhs_len + rhs_len);
    if (!result)
    {
        return NULL;
    }
    int64_t index = 0;
    /* copy pointer payloads verbatim; value owners manage lifetimes */
    for (int64_t i = 0; i < lhs_len; ++i)
    {
        SailfinValue value = NULL;
        if (lhs && lhs->data)
        {
            value = lhs->data[i];
        }
        result->data[index++] = value;
    }
    for (int64_t i = 0; i < rhs_len; ++i)
    {
        SailfinValue value = NULL;
        if (rhs && rhs->data)
        {
            value = rhs->data[i];
        }
        result->data[index++] = value;
    }
    return result;
}

SailfinArray *sailfin_runtime_array_map(SailfinArray *array, void *callback)
{
    (void)array;
    (void)callback;
    return alloc_array(0);
}

SailfinArray *sailfin_runtime_array_filter(SailfinArray *array, void *callback)
{
    (void)array;
    (void)callback;
    return alloc_array(0);
}

void *sailfin_runtime_array_reduce(SailfinArray *array, SailfinString initial, void *callback)
{
    (void)array;
    (void)callback;
    return string_clone(initial);
}

void *sailfin_runtime_get_field(void *base, SailfinString field)
{
    (void)base;
    (void)field;
    return NULL;
}

void sailfin_runtime_sleep(double duration)
{
    (void)duration;
}

void *sailfin_runtime_parallel(void *callable)
{
    return callable;
}

void sailfin_runtime_spawn(void *callable, void *argument)
{
    (void)callable;
    (void)argument;
}

static int debug_print_count = 0;
static const int debug_print_limit = 200;

static int debug_should_log(void)
{
    if (debug_print_count < debug_print_limit)
    {
        debug_print_count++;
        return 1;
    }
    if (debug_print_count == debug_print_limit)
    {
        fprintf(stderr, "[stage2-info] <additional messages suppressed>\n");
    }
    debug_print_count++;
    return 0;
}

void sailfin_runtime_print_info(SailfinString value)
{
    if (debug_should_log())
    {
        fprintf(stderr, "[stage2-info] %s\n", string_data(value));
    }
}

void sailfin_runtime_debug_i64(int64_t value)
{
    if (debug_should_log())
    {
        fprintf(stderr, "[stage2-debug] %lld\n", (long long)value);
    }
}

void sailfin_runtime_debug_label_i64(SailfinString label, int64_t value)
{
    if (debug_should_log())
    {
        fprintf(stderr, "[stage2-debug] %s=%lld\n", string_data(label), (long long)value);
    }
}

void sailfin_runtime_debug_ptr(SailfinString label, void *value)
{
    if (debug_should_log())
    {
        fprintf(stderr, "[stage2-debug] %s=%p\n", string_data(label), value);
    }
}

void sailfin_runtime_debug_text(SailfinString label, SailfinString value)
{
    if (debug_should_log())
    {
        fprintf(stderr, "[stage2-debug] %s=\"%s\"\n", string_data(label), string_data(value));
    }
}

void sailfin_runtime_print_warn(SailfinString value)
{
    fprintf(stderr, "[stage2-warn] %s\n", string_data(value));
}

void sailfin_runtime_print_error(SailfinString value)
{
    fprintf(stderr, "[stage2-error] %s\n", string_data(value));
}

void sailfin_runtime_raise_value_error(SailfinString message)
{
    const char *text = string_data(message);
    int64_t length = string_length(message);
    int preview = 0;
    if (length > 0)
    {
        preview = (int)length;
        if (preview > 120)
        {
            preview = 120;
        }
    }
    fprintf(stderr,
            "[stage2-runtime] raise_value_error ptr=%p len=%lld preview=\"%.*s\"\n",
            (void *)message,
            (long long)length,
            preview,
            text ? text : "");
    if (length > preview)
    {
        fprintf(stderr,
                "[stage2-runtime] raise_value_error truncated actual_len=%lld\n",
                (long long)length);
    }
    fflush(stderr);
    abort();
}

void *sailfin_runtime_log_execution(SailfinString value)
{
    return string_clone(value);
}

void *sailfin_runtime_to_debug_string(SailfinString value)
{
    return string_clone(value);
}

void *sailfin_runtime_resolve_type(SailfinString value)
{
    return string_clone(value);
}

void *sailfin_runtime_create_capability_grant(void *effects)
{
    (void)effects;
    return malloc(1);
}

void *sailfin_runtime_create_filesystem_bridge(void *config)
{
    (void)config;
    return malloc(1);
}

void *sailfin_runtime_create_http_bridge(void *config)
{
    (void)config;
    return malloc(1);
}

void *sailfin_runtime_create_model_bridge(void *config)
{
    (void)config;
    return malloc(1);
}

void *sailfin_runtime_channel(double capacity)
{
    (void)capacity;
    return malloc(1);
}

void sailfin_runtime_serve(void *handler, void *config)
{
    (void)handler;
    (void)config;
}

void *char_code_wrapper(SailfinString value)
{
    return string_clone(value);
}

void *sailfin_runtime_instance_of_wrapper(void *value, void *type_name)
{
    (void)value;
    (void)type_name;
    return NULL;
}

double sailfin_runtime_char_code(SailfinString value)
{
    static int debug_char_code_count = 0;
    const char *raw = string_data(value);
    unsigned char ch = (raw && raw[0] != '\0') ? (unsigned char)raw[0] : 0;
    if (debug_char_code_count < debug_print_limit)
    {
        fprintf(stderr, "[stage2-debug] char_code ptr=%p char=0x%02x\n", (void *)value, ch);
        fflush(stderr);
    }
    debug_char_code_count++;
    if (!raw || raw[0] == '\0')
    {
        return 0.0;
    }
    return (double)ch;
}

int sailfin_intrinsic_fs_exists(SailfinString path)
{
    (void)path;
    return 0;
}

void *sailfin_adapter_fs_read_file(SailfinString path)
{
    (void)path;
    return string_from_cstr("");
}
