from lorem_text import lorem

file_path = 'generated_text.txt'  # Replace with the desired file path
target_file_size = 512 * 1024 * 1024  # 512MB in bytes

with open(file_path, 'w') as file:
    while file.tell() < target_file_size:
        file.write(lorem.text())

print("Text file generated successfully!")