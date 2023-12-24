
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

其他AT命令[点击这里](https://raw.githubusercontent.com/Coolkids/photonicat_build/main/Quectel_RG520N%26RG525F%26RG5x0F%26RM5x0N_Series_AT_Commands_Manual_V1.0.0_Preliminary_20230731.pdf)