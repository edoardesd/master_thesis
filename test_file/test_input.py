import subprocess



starting_day="25:05:17"
starting_time="160825"
dev="1"
up="upgrade"

cmd2 = "apt-get upgrade"

cmd = "mysqlimport --ignore-lines=1 --fields-terminated-by=, --columns='timestamp,echo_time,rssi,tpl,lq' \
								--local -u root -p test \
								/home/edoardesd/master_thesis/"+starting_day+"/"+starting_time+"/"+dev+"__"+starting_time+"_bluetooth.csv"

out = subprocess.Popen(cmd2, stdout=subprocess.PIPE)

print out
#out.stdin.write("distributedpass\n")

#print out
#stdout_data = out.communicate(input='distributedpass\n')[0]

