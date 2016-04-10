
import sys, re
from collections import Counter



most_common = True

num_words = 10

counter = Counter(word.lower()
                  for line in sys.stdin
                  for word in line.strip().split() if word)


for word, count in counter.most_common(num_words) if most_common else list(reversed(counter.most_common())):
    sys.stdout.write(str(count))
    sys.stdout.write("\t")
    sys.stdout.write(word)
    sys.stdout.write("\n")



#these supposed to be another separated example...


regex = sys.argv[1]

count_lines, count_words = 0, 0
for line in sys.stdin:
    print 'something'
    count_lines += 1
    if re.search(regex, line):
        count_words += 1
        #sys.stdout.write(line)

print  count_words, 'times', sys.argv[1], 'in', count_lines, 'lines'