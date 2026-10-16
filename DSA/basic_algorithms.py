def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr


def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    merged = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            merged.append(left[i])
            i += 1
        else:
            merged.append(right[j])
            j += 1
    merged.extend(left[i:])
    merged.extend(right[j:])
    return merged


def binary_search(arr, target):
    low, high = 0, len(arr) - 1
    while low <= high:
        mid = (low + high) // 2
        if arr[mid] == target:
            return mid
        if arr[mid] < target:
            low = mid + 1
        else:
            high = mid - 1
    return -1


def fibonacci(n):
    if n <= 0:
        return []
    sequence = [0, 1]
    while len(sequence) < n:
        sequence.append(sequence[-1] + sequence[-2])
    return sequence[:n]


def factorial(n):
    if n < 0:
        return None
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result


def parse_numbers(input_string):
    try:
        return [int(x.strip()) for x in input_string.split(',') if x.strip()]
    except ValueError:
        return None


def prompt_list():
    data = input('Enter a list of integers separated by commas: ')
    nums = parse_numbers(data)
    if nums is None:
        print('Invalid input. Use comma-separated integers.')
    return nums


def prompt_number(message):
    try:
        return int(input(message))
    except ValueError:
        print('Invalid input. Enter an integer.')
        return None


def main():
    while True:
        print('\nChoose an algorithm:')
        print('1. Bubble Sort')
        print('2. Merge Sort')
        print('3. Binary Search')
        print('4. Fibonacci Sequence')
        print('5. Factorial')
        print('6. Quit')
        choice = input('Enter choice (1-6): ').strip()

        if choice == '1':
            nums = prompt_list()
            if nums is not None:
                print('Result:', bubble_sort(nums.copy()))
        elif choice == '2':
            nums = prompt_list()
            if nums is not None:
                print('Result:', merge_sort(nums))
        elif choice == '3':
            nums = prompt_list()
            if nums is not None:
                nums_sorted = sorted(nums)
                target = prompt_number('Enter target integer to search for: ')
                if target is not None:
                    index = binary_search(nums_sorted, target)
                    print('Sorted list:', nums_sorted)
                    print('Target index:', index)
        elif choice == '4':
            n = prompt_number('Enter number of Fibonacci elements: ')
            if n is not None:
                print('Result:', fibonacci(n))
        elif choice == '5':
            n = prompt_number('Enter an integer for factorial: ')
            if n is not None:
                print('Result:', factorial(n))
        elif choice == '6':
            print('Goodbye.')
            break
        else:
            print('Invalid choice. Please enter a number from 1 to 6.')


if __name__ == '__main__':
    main()
