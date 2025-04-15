import subprocess
import sys
import os

MY_LEXER = "./lexer"
EXAMPLE_LEXER = "/afs/ir/class/cs143/bin/lexer"

def run_lexer(cmd, test_file, out_file):
    with open(out_file, "w") as f:
        subprocess.run([cmd, test_file], stdout=f)

def compare_outputs(test_name, my_out, example_out):
    with open(my_out) as f1, open(example_out) as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

    mismatch = False
    for i, (l1, l2) in enumerate(zip(lines1, lines2), start=1):
        if l1.strip() != l2.strip():
            print(f"[{test_name}] ❌ Mismatch on line {i}:\n  Yours:    {l1.strip()}\n  Expected: {l2.strip()}")
            mismatch = True

    if len(lines1) != len(lines2):
        print(f"[{test_name}] ❌ Output lengths differ: yours={len(lines1)}, expected={len(lines2)}")
        mismatch = True

    if not mismatch:
        print(f"[{test_name}] ✅ Output matches expected lexer exactly.")

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 run_tests.py test1.cl [test2.cl ...]")
        sys.exit(1)

    for test_file in sys.argv[1:]:
        base = os.path.splitext(os.path.basename(test_file))[0]
        my_out = f"test_txt/{base}_my.txt"
        example_out = f"test_txt/{base}_ref.txt"

        run_lexer(EXAMPLE_LEXER, test_file, example_out)
        run_lexer(MY_LEXER, test_file, my_out)
        compare_outputs(test_file, my_out, example_out)

if __name__ == "__main__":
    main()