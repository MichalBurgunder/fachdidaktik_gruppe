

text = "morgen in der pause gehen wir zum kiosk"

import random 

def scramble(arr):
    """Return a new shuffled copy of arr (Fisher–Yates)."""
    result = arr[:]          # copy so the original stays intact
    random.shuffle(result)   # may raise TypeError if arr is not mutable
    return result

# print("".join(scramble(list(text))))
print(len(list(text)))


import random
import string

def random_string(length):
    """Return a random string of the given length (letters + digits)."""
    chars = string.ascii_letters
    return ''.join(random.choices(chars, k=length))

def random_password(length):
    """Letters, digits and punctuation - better for passwords."""
    chars = string.ascii_letters
    return ''.join(random.choices(chars, k=length))

# Examples
print(random_string(10))     # e.g. 'aB3xK9mQ2p'
print(random_password(32).lower())   # e.g. 'k#7Pq!vR2x$m'
