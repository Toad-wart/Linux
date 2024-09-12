#!/bin/sh

#Получаем список диапазонов точек из файла
for tt_ip in $(cat ip_tt)
        do
                tt_name=$(nmap $tt_ip -p 445 | grep "srv01" | awk '{print $5}' | cut -d'-' -f1) #получили имя сервера
                name_err=$(nmap $tt_ip -p 445| grep -Ev $tt_name | grep "\-ws" | awk '{print $5}' | cut -d'.' -f1 ) #получили  имена машин с префиксом не совпадающим с именем сервера в диапазаоне
done
