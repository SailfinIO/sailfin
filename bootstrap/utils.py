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
        def replace_member_access(match):
            expr = match.group(1).strip()
            # Check if this is a member access pattern (obj.member)
            if '.' in expr and not expr.startswith('"') and not expr.startswith("'"):
                # Replace obj.member with safe property access
                parts = expr.split('.')
                if len(parts) == 2:
                    obj, member = parts
                    # Generate safe access that works for both dicts and objects
                    return "{" + f"({obj}['{member}'] if isinstance({obj}, dict) else {obj}.{member})" + "}"
            return "{" + expr + "}"

        interpolated = pattern.sub(replace_member_access, s)
        return f"f\"{interpolated}\""
    else:
        return f"\"{s}\""
