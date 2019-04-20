import urllib.request
import re
import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt
from collections import Counter

def plot(result_time):
  time_list = []

  # build the time list
  for r in result_time:
    time = r.split("originally announced</span>")[1].split(".")[0].strip().split(" ")[1]
    time_list.append(int(time))

  if not len(time_list):
    print("no result!")
    return

  # count the number of each year
  quantity = []
  for t in range(min(time_list),max(time_list)+1):
    count = time_list.count(t)
    quantity.append(int(count))

  # plot
  y_pos = np.arange(min(time_list),max(time_list)+1)
  plt.bar(y_pos, quantity, align='center')
  plt.xticks(y_pos)
  plt.ylabel('quantity')
  plt.yticks(range(min(quantity),max(quantity)+1))
  plt.title('the number of papers been published each year of an author')
  plt.show()

def find_coauthor(result_coauthor):
  author_list = []
  count = 0
  for r in result_coauthor:
    p = re.compile('<.*?>')
    coauthor=p.sub('', r)
    for m in coauthor.split("Authors:")[1].split(","):
      if m.strip()[0:2] == "et":
        break
      author_list.append(m.strip())
  result = Counter(author_list)
  result = sorted(result.items())

  for a in result:
    print ('%s: %dtimes' % (a[0], a[1]))

def main():

  # input
  input_author = input("Input Author: ")

  # declaration
  author = input_author.replace(" ", "+")
  html_str=""
  page_number = 0
  pattern_error = 'Sorry, your query for'
  pattern_author = 'title is-5 mathjax[\s\S]*?</p>'
  pattern_time = 'originally announced</span>[\s\S]*?</p>'
  pattern_coauthor = '<p class="authors[\s\S]*?</p>'

  # get all the content in each page
  while 1:
    url = "https://arxiv.org/search/?query="+ author + "&searchtype=author&size=200"+"&start="+str(page_number)
    content = urllib.request.urlopen(url)
    tmp = content.read().decode('utf-8')
    if re.findall(pattern_error,tmp):
      break
    html_str = html_str + tmp
    page_number = page_number + 200

  # result_author = re.findall(pattern_author,html_str)
  result_time = re.findall(pattern_time,html_str)
  result_coauthor = re.findall(pattern_coauthor,html_str)

  # print("[ Author: " + author + "]")
  # for r in result_author:
  #   title = r.split("title is-5 mathjax\">")[1].split("</p>")[0].strip()
  #   print(title)

  find_coauthor(result_coauthor)
  plot(result_time)


if __name__== "__main__":
  main()
