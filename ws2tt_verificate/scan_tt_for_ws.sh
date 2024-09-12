  GNU nano 4.8                                                                                 scan_tt_for_ws.sh
#!/bin/sh

#Получаем список диапазонов точек из файла
for tt_ip in $(cat ip_tt)
        do
                #echo tt_address  $tt_ip
                tt_name=$(nmap $tt_ip -p 445 | grep "srv01" | awk '{print $5}' | cut -d'-' -f1) #получили имя сервера
                #echo tt_name $tt_name
                name_err=$(nmap $tt_ip -p 445| grep -Ev $tt_name | grep "\-ws" | awk '{print $5}' | cut -d'.' -f1 ) #получили  имена машин с префиксом не совпадающим с именем сервера в диапазаоне
                echo Список ошибочных имен пк для диапазона $tt_ip и имени ТТ $tt_name: $name_err
done

