# bootstrap/utils.py

import re
import uuid


def generate_unique_name(prefix='func'):
    return f"{prefix}_{uuid.uuid4().hex}"


def interpolate_string(s):
    """
    Converts custom string interpolation syntax {{var}} to Python f-string syntax {var}
    and prepends 'f' to the string.
    """
    pattern = re.compile(r'\{\{([^{}]+)\}\}')
    if pattern.search(s):
        interpolated = pattern.sub(r'{\1}', s)
        return f"f\"{interpolated}\""
    else:
        return f"\"{s}\""
