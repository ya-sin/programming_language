import urllib.request
import re
import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt
def plot(result_time):
  time_list = []

  for r in result_time:
    time = r.split("originally announced</span>")[1].split(".")[0].strip().split(" ")[1]
    time_list.append(int(time))

  if not len(time_list):
    print("no result!")
    return

  # plot
  y_pos = np.arange(min(time_list),max(time_list)+1)
  quantity = []
  for t in range(min(time_list),max(time_list)+1):
    count = time_list.count(t)
    quantity.append(int(count))

  plt.bar(y_pos, quantity, align='center')
  plt.xticks(y_pos)
  plt.ylabel('quantity')
  plt.yticks(range(min(quantity),max(quantity)+1))
  plt.title('the number of papers been published each year of an author')

  plt.show()
def find_coauthor():
  
def main():
  # input_T = "<b>This is test.</b><p> Enter any text.</p><div> The place is really beautiful.</div><img src=''>"
  # p = re.compile('<.*?>')
  # print(p.sub('', input_T))
  input_author = input("Input Author: ")
  author = input_author.replace(" ", "+")

  # author = "Ian+Goodfellow"
  html_str=""
  page_number = 0
  pattern_error = 'Sorry, your query for'
  while 1:
    url = "https://arxiv.org/search/?query="+ author + "&searchtype=author&size=200"+"&start="+str(page_number)
    content = urllib.request.urlopen(url)
    tmp = content.read().decode('utf-8')
    # print(tmp)
    if re.findall(pattern_error,tmp):
      break
    html_str = html_str + tmp
    # print(html_str)
    page_number = page_number + 200
  # url = "https://arxiv.org/search/?query="+ author + "&searchtype=author&size=200"+"&start="+ str(page_number)
  # content = urllib.request.urlopen(url)
  # html_str = content.read().decode('utf-8')
  pattern_author = 'title is-5 mathjax[\s\S]*?</p>'
  pattern_time = 'originally announced</span>[\s\S]*?</p>'
  pattern_coauthor = 'authors[\s\S]*?</p>'
  # test = re.findall(pattern_error,html_str)
  result_author = re.findall(pattern_author,html_str)
  result_time = re.findall(pattern_time,html_str)
  result_coauthor = re.findall(pattern_coauthor,html_str)

  print("[ Author: " + author + "]")

  for r in result_author:
    title = r.split("title is-5 mathjax\">")[1].split("</p>")[0].strip()
    print(title)

  plot(result_time)
  find_coauthor(result_coauthor)


if __name__== "__main__":
  main()
