



- 查看CPU的逻辑核心数

```sh
cat /proc/cpuinfo| grep "processor"| wc -l
```



- 查询每个进程的CPU占用

```sh
ps -axf -o "pid %cpu"
```



- 根据占用率过滤，10%的占用率为例

```sh
ps -axf -o "pid %cpu" | awk '$2>10 {print $1}'
```





- 查询对应进程的启动时间

```sh
ps -p pid -o etime
```



- 脚本

```sh
#!/bin/bash
set -ex
# 期望限制的CPU使用率，90为90%
EXPECT_RATIO=90
# 进程的最小运行时间，有些服务启动的时候CPU使用率会比较高，避免误杀掉刚启动的服务。单位秒，如120
EXPECT_MIN_SECONDS=120

# CPU的核心数
CPU_NUMBER=`cat /proc/cpuinfo| grep "processor"| wc -l`
# CPU使用率转换
CPU_USED=$[ ${CPU_NUMBER} * ${EXPECT_RATIO} ]

# 根据CPU使用率，查出该kill调的进程
PID=`ps -axf -o "pid %cpu" | awk '$2>'${CPU_USED}' {print $1}'`
if [ "${PID}" != "" ]; then
    # 查询进程的启动时间
    PID_START_SECONDS=`ps -p ${PID} -o etimes`

    # 进程的启动时间大于设置的容忍值，就杀掉进程
    if [ "${PID_START_SECONDS}" > "${EXPECT_MIN_SECONDS}" ]; then
        ps -aux | grep ${PID} | grep -v grep >> /root/kill.record
        kill -9 ${PID}
    fi
fi
```



```sh
echo "* * * * * root /bin/bash /root/monitor.sh" >> /etc/crontab
```



