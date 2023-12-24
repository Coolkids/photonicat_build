
- 设置为RNDIS模式
```
AT+QCFG="usbnet",3
```

- 修改APN
```
AT+CGDCONT=1,"IPV4V6","auto"
```
- 检查网络状态
```
AT+QENG="servingcell"
```

- 重启模块
```
AT+CFUN=1,1
```

- 使用IPPT模式
```
AT+QMAP="MPDN_RULE",0,1,0,1,1,"FF:FF:FF:FF:FF:FF" 
```

