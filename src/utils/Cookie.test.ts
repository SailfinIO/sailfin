import { Cookie, parse, serialize } from './Cookie';
import { Priority, SameSite } from '../enums';
import { CookieError } from '../errors';

describe('parse', () => {
  it('should return an empty object for empty header', () => {
    const result = parse('');
    expect(result).toEqual({});
  });

  it('should throw an error when the cookie string has an empty name', () => {
    const invalidCookieString = '=value';
    expect(() => Cookie.parse(invalidCookieString)).toThrow(
      'Failed to parse cookie string: Missing name or value.',
    );
  });

  it('should correctly parse cookie values containing multiple equals signs', () => {
    const header = 'token=a=b=c; sessionId=abc123';
    const result = parse(header);
    expect(result).toEqual({ token: 'a=b=c', sessionId: 'abc123' });
  });

  it('should parse valid Max-Age attribute', () => {
    const cookieString = 'sessionId=abc123; Max-Age=3600';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.name).toBe('sessionId');
    expect(parsed.value).toBe('abc123');
    expect(parsed.options?.maxAge).toBe(3600);
  });

  it('should throw error for non-numeric Max-Age value', () => {
    const cookieString = 'sessionId=abc123; Max-Age=invalid';
    expect(() => Cookie.parse(cookieString)).toThrow(
      'Invalid Max-Age value: invalid',
    );
  });

  it('should parse cookie without Max-Age attribute', () => {
    const cookieString = 'sessionId=abc123';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.name).toBe('sessionId');
    expect(parsed.value).toBe('abc123');
    expect(parsed.options?.maxAge).toBeUndefined();
  });

  it('should parse cookies with empty values', () => {
    const header = 'emptyCookie=; sessionId=abc123';
    const result = parse(header);
    expect(result).toEqual({ emptyCookie: '', sessionId: 'abc123' });
  });

  it('should parse valid Domain attribute', () => {
    const cookieString = 'sessionId=abc123; Domain=example.com';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.domain).toBe('example.com');
  });

  it('should throw error for invalid Domain value', () => {
    const cookieString = 'sessionId=abc123; Domain=invalid domain';
    expect(() => Cookie.parse(cookieString)).toThrow(
      'Invalid domain: invalid domain',
    );
  });
  it('should parse cookie without Domain attribute', () => {
    const cookieString = 'sessionId=abc123';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.domain).toBeUndefined();
  });

  it('should parse valid Path attribute', () => {
    const cookieString = 'sessionId=abc123; Path=/home';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.path).toBe('/home');
  });

  it('should parse cookie without Path attribute', () => {
    const cookieString = 'sessionId=abc123';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.path).toBeUndefined();
  });

  it('should parse multiple attributes including Max-Age, Domain, and Path', () => {
    const cookieString =
      'sessionId=abc123; Max-Age=3600; Domain=example.com; Path=/home';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.name).toBe('sessionId');
    expect(parsed.value).toBe('abc123');
    expect(parsed.options?.maxAge).toBe(3600);
    expect(parsed.options?.domain).toBe('example.com');
    expect(parsed.options?.path).toBe('/home');
  });

  it('should handle duplicate Max-Age attributes by taking the last one', () => {
    const cookieString = 'sessionId=abc123; Max-Age=3600; Max-Age=7200';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.maxAge).toBe(7200);
  });

  it('should parse a single cookie', () => {
    const header = 'sessionId=abc123';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc123' });
  });

  it('should parse multiple cookies', () => {
    const header = 'sessionId=abc123; userId=789xyz';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc123', userId: '789xyz' });
  });

  it('should handle whitespace around keys and values', () => {
    const header = ' sessionId = abc123 ; userId = 789xyz ';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc123', userId: '789xyz' });
  });

  it('should decode encoded cookie values', () => {
    const header = 'sessionId=abc%20123';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc 123' });
  });

  it('should use custom decode function if provided', () => {
    const header = 'sessionId=abc%20123';
    const customDecode = jest.fn((val: string) => val.replace('%20', ' '));
    const result = parse(header, { decode: customDecode });
    expect(customDecode).toHaveBeenCalledWith('abc%20123');
    expect(result).toEqual({ sessionId: 'abc 123' });
  });

  it('should ignore invalid cookie segments', () => {
    const header = 'invalidSegment; sessionId=abc123';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc123' });
  });

  it('should skip whitespace-only segments', () => {
    const header = '   ;  sessionId=abc123';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc123' });
  });

  it('should handle trailing whitespace in cookie values', () => {
    const header = 'sessionId=abc123   ;';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc123' });
  });

  it('should return an object with no prototype', () => {
    const header = 'sessionId=abc123';
    const result = parse(header);
    expect(Object.getPrototypeOf(result)).toBeNull();
  });

  it('should parse the Partitioned attribute correctly', () => {
    const cookieString = 'sessionId=abc123; Partitioned';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.name).toBe('sessionId');
    expect(parsed.value).toBe('abc123');
    expect(parsed.options?.partitioned).toBe(true);
  });

  it('should handle absence of the Partitioned attribute', () => {
    const cookieString = 'sessionId=abc123';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.partitioned).toBeUndefined();
  });

  it('should throw error for invalid Priority value in parse', () => {
    const cookieString = 'sessionId=abc123; Priority=urgent';
    expect(() => Cookie.parse(cookieString)).toThrow(
      'Invalid Priority value: urgent',
    );
  });

  it('should parse Priority=LOW correctly', () => {
    const cookieString = 'sessionId=abc123; Priority=LOW';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.priority).toBe(Priority.LOW);
  });

  it('should parse Priority=Medium correctly', () => {
    const cookieString = 'sessionId=abc123; Priority=Medium';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.priority).toBe(Priority.MEDIUM);
  });

  it('should parse Priority=high correctly', () => {
    const cookieString = 'sessionId=abc123; Priority=high';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.priority).toBe(Priority.HIGH);
  });

  it('should parse multiple attributes including Partitioned and Priority', () => {
    const cookieString = 'sessionId=abc123; Partitioned; Priority=Medium';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.name).toBe('sessionId');
    expect(parsed.value).toBe('abc123');
    expect(parsed.options?.partitioned).toBe(true);
    expect(parsed.options?.priority).toBe(Priority.MEDIUM);
  });

  it('should handle duplicate Partitioned attributes by setting it to true', () => {
    const cookieString = 'sessionId=abc123; Partitioned; Partitioned';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.partitioned).toBe(true);
  });

  it('should handle duplicate Priority attributes by taking the last one', () => {
    const cookieString = 'sessionId=abc123; Priority=Low; Priority=High';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.priority).toBe(Priority.HIGH);
  });
});

describe('serialize', () => {
  it('should serialize a basic cookie', () => {
    const result = serialize('sessionId', 'abc123');
    expect(result).toBe('sessionId=abc123');
  });

  it('should throw error for invalid domain', () => {
    expect(() =>
      serialize('sessionId', 'abc123', { domain: 'invalid domain' }),
    ).toThrow('Invalid domain: invalid domain');
  });

  it('should throw error for non-integer maxAge', () => {
    // @ts-ignore Testing runtime behavior with invalid input
    expect(() => serialize('sessionId', 'abc123', { maxAge: '3600' })).toThrow(
      'Invalid Max-Age: 3600',
    );
  });

  it('should serialize with SameSite=None', () => {
    const result = serialize('sessionId', 'abc123', {
      sameSite: SameSite.NONE,
    });
    expect(result).toBe('sessionId=abc123; SameSite=None');
  });

  it('should serialize with Priority in lowercase', () => {
    const result = serialize('sessionId', 'abc123', {
      priority: 'low' as Priority,
    });
    expect(result).toBe('sessionId=abc123; Priority=Low');
  });

  it('should throw error when Expires is not a Date object', () => {
    expect(() =>
      // @ts-ignore Testing runtime behavior with invalid input
      serialize('sessionId', 'abc123', { expires: 'not-a-date' }),
    ).toThrow('Invalid Expires: not-a-date');
  });

  it('should not serialize Partitioned when set to false', () => {
    const result = serialize('sessionId', 'abc123', { partitioned: false });
    expect(result).toBe('sessionId=abc123');
  });

  it('should ignore unknown attributes without affecting serialization', () => {
    // @ts-ignore Testing runtime behavior with unknown attribute
    const result = serialize('sessionId', 'abc123', { unknownAttr: 'value' });
    expect(result).toBe('sessionId=abc123');
  });

  it('should serialize with the Partitioned attribute', () => {
    const result = serialize('sessionId', 'abc123', { partitioned: true });
    expect(result).toBe('sessionId=abc123; Partitioned');
  });

  it('should throw error for invalid path', () => {
    expect(() =>
      serialize('sessionId', 'abc123', { path: 'invalid;path' }),
    ).toThrow('Invalid path: invalid;path');
  });

  it('should throw error for invalid expires', () => {
    expect(() =>
      // @ts-ignore Testing runtime behavior with invalid input
      serialize('sessionId', 'abc123', { expires: 'invalid date' }),
    ).toThrow('Invalid Expires: invalid date');
  });

  it('should encode cookie value', () => {
    const result = serialize('sessionId', 'abc 123');
    expect(result).toBe('sessionId=abc%20123');
  });

  it('should ignore unknown attributes in options', () => {
    // @ts-ignore Testing runtime behavior with invalid input
    const result = serialize('sessionId', 'abc123', { unknownAttr: true });
    expect(result).toBe('sessionId=abc123');
  });

  it('should use custom encode function if provided', () => {
    const customEncode = jest.fn((val: string) => val.replace(' ', '_'));
    const result = serialize('sessionId', 'abc 123', { encode: customEncode });
    expect(customEncode).toHaveBeenCalledWith('abc 123');
    expect(result).toBe('sessionId=abc_123');
  });

  it('should throw error for invalid cookie name', () => {
    expect(() => serialize('invalid name', 'value')).toThrow(
      'Invalid cookie name: invalid name',
    );
  });

  it('should serialize with maxAge attribute', () => {
    const result = serialize('sessionId', 'abc123', { maxAge: 3600 });
    expect(result).toBe('sessionId=abc123; Max-Age=3600');
  });

  it('should serialize with domain attribute', () => {
    const result = serialize('sessionId', 'abc123', { domain: 'example.com' });
    expect(result).toBe('sessionId=abc123; Domain=example.com');
  });

  it('should throw an error for invalid SameSite values during serialization', () => {
    expect(() =>
      serialize('sessionId', 'abc123', { sameSite: 'invalid' as SameSite }),
    ).toThrow('Invalid SameSite: invalid');
  });

  it('should serialize with path attribute', () => {
    const result = serialize('sessionId', 'abc123', { path: '/home' });
    expect(result).toBe('sessionId=abc123; Path=/home');
  });

  it('should serialize with expires attribute', () => {
    const date = new Date('2023-01-01T00:00:00Z');
    const result = serialize('sessionId', 'abc123', { expires: date });
    expect(result).toBe(
      'sessionId=abc123; Expires=Sun, 01 Jan 2023 00:00:00 GMT',
    );
  });

  it('should serialize with httpOnly and secure attributes', () => {
    const result = serialize('sessionId', 'abc123', {
      httpOnly: true,
      secure: true,
    });
    expect(result).toBe('sessionId=abc123; HttpOnly; Secure');
  });

  it('should serialize with priority and sameSite attributes', () => {
    const result = serialize('sessionId', 'abc123', {
      priority: Priority.HIGH,
      sameSite: SameSite.STRICT,
    });
    expect(result).toBe('sessionId=abc123; Priority=High; SameSite=Strict');
  });

  it('should throw error for invalid priority', () => {
    expect(() =>
      // @ts-ignore
      serialize('sessionId', 'abc123', { priority: 'invalid' }),
    ).toThrow('Invalid Priority: invalid');
  });

  it('should throw error for invalid sameSite', () => {
    expect(() =>
      // @ts-ignore
      serialize('sessionId', 'abc123', { sameSite: 'invalid' }),
    ).toThrow('Invalid SameSite: invalid');
  });

  it('should handle multiple attributes', () => {
    const date = new Date('2023-01-01T00:00:00Z');
    const result = serialize('sessionId', 'abc123', {
      maxAge: 3600,
      domain: 'example.com',
      path: '/home',
      expires: date,
      httpOnly: true,
      secure: true,
      priority: Priority.MEDIUM,
      sameSite: SameSite.LAX,
    });
    expect(result).toBe(
      'sessionId=abc123; Max-Age=3600; Domain=example.com; Path=/home; Expires=Sun, 01 Jan 2023 00:00:00 GMT; HttpOnly; Secure; Priority=Medium; SameSite=Lax',
    );
  });

  it('should serialize with the Partitioned attribute set to true', () => {
    const result = serialize('sessionId', 'abc123', { partitioned: true });
    expect(result).toBe('sessionId=abc123; Partitioned');
  });

  it('should not serialize the Partitioned attribute when set to false', () => {
    const result = serialize('sessionId', 'abc123', { partitioned: false });
    expect(result).toBe('sessionId=abc123');
  });

  it('should serialize Priority=low correctly', () => {
    const result = serialize('sessionId', 'abc123', {
      priority: 'low' as Priority,
    });
    expect(result).toBe('sessionId=abc123; Priority=Low');
  });

  it('should serialize Priority=MEDIUM correctly', () => {
    const result = serialize('sessionId', 'abc123', {
      priority: 'MEDIUM' as Priority,
    });
    expect(result).toBe('sessionId=abc123; Priority=Medium');
  });

  it('should serialize Priority=High correctly', () => {
    const result = serialize('sessionId', 'abc123', {
      priority: 'High' as Priority,
    });
    expect(result).toBe('sessionId=abc123; Priority=High');
  });

  it('should throw error when serializing with invalid Priority value', () => {
    expect(() =>
      // @ts-ignore Testing runtime behavior with invalid input
      serialize('sessionId', 'abc123', { priority: 'urgent' }),
    ).toThrow('Invalid Priority: urgent');
  });
});

describe('Cookie Class', () => {
  it('should create a Cookie instance with valid parameters', () => {
    const cookie = new Cookie('test', 'value', { httpOnly: true });
    expect(cookie.name).toBe('test');
    expect(cookie.value).toBe('value');
    expect(cookie.options?.httpOnly).toBe(true);
  });

  it('should throw an error when parsing a string with no valid cookies', () => {
    const invalidCookieString = 'invalidSegment; anotherInvalidSegment';
    expect(() => Cookie.parse(invalidCookieString)).toThrow(
      'Failed to parse cookie string: No valid cookies found.',
    );
  });

  it('should parse only the first valid cookie when multiple are present', () => {
    const cookieString = 'sessionId=abc123; userId=789xyz';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.name).toBe('sessionId');
    expect(parsed.value).toBe('abc123');
    expect(parsed.options).toEqual({});
  });

  it('should throw an error when Expires attribute is invalid in Cookie.parse', () => {
    const cookieString = 'sessionId=abc123; Expires=invalid-date';
    expect(() => Cookie.parse(cookieString)).toThrow(
      'Invalid Expires value: invalid-date',
    );
  });

  it('should throw an error when setting an invalid domain using setOptions', () => {
    const cookie = new Cookie('session', 'abc123');
    expect(() => cookie.setOptions({ domain: 'invalid domain' })).toThrow(
      'Invalid domain: invalid domain',
    );
  });

  it('should throw an error when setting an invalid path using setOptions', () => {
    const cookie = new Cookie('session', 'abc123');
    expect(() => cookie.setOptions({ path: 'invalid;path' })).toThrow(
      'Invalid path: invalid;path',
    );
  });

  it('should serialize cookie with Priority=High and SameSite=Strict', () => {
    const cookie = new Cookie('test', 'value', {
      priority: Priority.HIGH,
      sameSite: SameSite.STRICT,
    });
    expect(cookie.serialize()).toBe(
      'test=value; Priority=High; SameSite=Strict',
    );
  });

  it('should throw error for invalid priority value in serialize', () => {
    expect(() =>
      // @ts-ignore Testing runtime behavior with invalid input
      serialize('sessionId', 'abc123', { priority: 'invalid' }),
    ).toThrow('Invalid Priority: invalid');
  });

  it('should throw error for invalid SameSite value in serialize', () => {
    expect(() =>
      // @ts-ignore Testing runtime behavior with invalid input
      serialize('sessionId', 'abc123', { sameSite: 'invalid' }),
    ).toThrow('Invalid SameSite: invalid');
  });

  it('should correctly skip leading and trailing whitespaces in parse', () => {
    const header = '   sessionId=abc123   ;   userId=789xyz   ';
    const result = parse(header);
    expect(result).toEqual({ sessionId: 'abc123', userId: '789xyz' });
  });

  it('should not include unnecessary whitespaces in serialized cookie', () => {
    const result = serialize('sessionId', 'abc123', { path: '/home ' });
    expect(result).toBe('sessionId=abc123; Path=/home');
  });

  it('should throw an error for invalid cookie name', () => {
    expect(() => new Cookie('invalid name', 'value')).toThrow(CookieError);
  });

  it('should throw an error for invalid cookie value', () => {
    expect(() => new Cookie('name', 'invalid;value')).toThrow(CookieError);
  });

  it('should serialize correctly', () => {
    const cookie = new Cookie('sessionId', 'abc123', {
      httpOnly: true,
      secure: true,
      sameSite: SameSite.LAX,
    });
    const serialized = cookie.serialize();
    expect(serialized).toBe('sessionId=abc123; HttpOnly; Secure; SameSite=Lax');
  });

  it('should parse a cookie string into a Cookie instance', () => {
    const cookieString = 'sessionId=abc123; HttpOnly; Secure; SameSite=Lax';
    const parsed = Cookie.parse(cookieString);
    expect(parsed).not.toBeNull();
    if (parsed) {
      expect(parsed.name).toBe('sessionId');
      expect(parsed.value).toBe('abc123');
      expect(parsed.options?.httpOnly).toBe(true);
      expect(parsed.options?.secure).toBe(true);
      expect(parsed.options?.sameSite).toBe(SameSite.LAX);
    }
  });

  it('should convert to JSON correctly', () => {
    const cookie = new Cookie('user', 'john_doe', {
      httpOnly: true,
      secure: true,
    });
    const json = cookie.toJSON();
    expect(json).toEqual({
      name: 'user',
      value: 'john_doe',
      options: { httpOnly: true, secure: true },
    });
  });

  it('should update the cookie value with setValue', () => {
    const cookie = new Cookie('token', 'initial');
    cookie.setValue('updatedValue');
    expect(cookie.value).toBe('updatedValue');
  });

  it('should throw an error when setting an invalid value using setValue', () => {
    const cookie = new Cookie('token', 'validValue');
    expect(() => cookie.setValue('invalid;value')).toThrow(CookieError);
  });

  it('should update the cookie options with setOptions', () => {
    const cookie = new Cookie('session', 'abc123', { httpOnly: true });
    cookie.setOptions({ secure: true, sameSite: SameSite.STRICT });
    expect(cookie.options).toEqual({
      httpOnly: true,
      secure: true,
      sameSite: SameSite.STRICT,
    });
  });

  it('should preserve existing options when updating with setOptions', () => {
    const cookie = new Cookie('session', 'abc123', {
      httpOnly: true,
      secure: false,
    });
    cookie.setOptions({ secure: true, path: '/home' });
    expect(cookie.options).toEqual({
      httpOnly: true,
      secure: true,
      path: '/home',
    });
  });
  it('should parse and set the Partitioned attribute correctly in Cookie instance', () => {
    const cookieString = 'sessionId=abc123; Partitioned';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.partitioned).toBe(true);
  });

  it('should parse and set the Priority attribute correctly in Cookie instance', () => {
    const cookieString = 'sessionId=abc123; Priority=medium';
    const parsed = Cookie.parse(cookieString);
    expect(parsed.options?.priority).toBe(Priority.MEDIUM);
  });

  it('should throw an error when parsing a cookie with invalid Priority attribute', () => {
    const cookieString = 'sessionId=abc123; Priority=invalid';
    expect(() => Cookie.parse(cookieString)).toThrow(
      'Invalid Priority value: invalid',
    );
  });

  it('should serialize a Cookie instance with Partitioned and Priority attributes', () => {
    const cookie = new Cookie('sessionId', 'abc123', {
      partitioned: true,
      priority: Priority.HIGH,
    });
    expect(cookie.serialize()).toBe(
      'sessionId=abc123; Partitioned; Priority=High',
    );
  });

  it('should update Partitioned attribute using setOptions', () => {
    const cookie = new Cookie('sessionId', 'abc123');
    cookie.setOptions({ partitioned: true });
    expect(cookie.options?.partitioned).toBe(true);
    expect(cookie.serialize()).toBe('sessionId=abc123; Partitioned');
  });

  it('should update Priority attribute using setOptions', () => {
    const cookie = new Cookie('sessionId', 'abc123');
    cookie.setOptions({ priority: Priority.LOW });
    expect(cookie.options?.priority).toBe(Priority.LOW);
    expect(cookie.serialize()).toBe('sessionId=abc123; Priority=Low');
  });

  it('should correctly parse a valid Expires attribute', () => {
    const cookieString =
      'sessionId=abc123; Expires=Wed, 21 Oct 2025 07:28:00 GMT';
    const parsed = Cookie.parse(cookieString);

    expect(parsed.name).toBe('sessionId');
    expect(parsed.value).toBe('abc123');
    expect(parsed.options?.expires).toEqual(
      new Date('Wed, 21 Oct 2025 07:28:00 GMT'),
    );
  });

  it('should throw a CookieError for an invalid SameSite value', () => {
    const cookieString = 'sessionId=abc123; SameSite=InvalidValue';

    expect(() => {
      Cookie.parse(cookieString);
    }).toThrow('Invalid SameSite value: InvalidValue');
  });
});
