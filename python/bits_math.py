def bit_reverse(value, bit_len):
    result = 0
    for src_bit in range(0, bit_len):
        result = (result << 1) | ((value >> src_bit) & 1)
    return result


def hex_str(value, bit_len):
    count = bit_len // 4
    return f"{value:0{count}X}"


def bin_str(value, bit_len):
    return f"{value:0{bit_len}b}"


def bits_to_bytes(value, bit_len):
    result = []
    for byte_index in range(0, bit_len, 8):
        byte = (value >> (bit_len - byte_index - 8)) & 0xFF
        result.append(byte)
    return result


def bytes_to_bits(value):
    result = 0
    for byte in value:
        result = (result << 8) | byte
    return result
