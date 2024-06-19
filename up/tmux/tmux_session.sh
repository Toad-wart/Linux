  GNU nano 7.2                                                                                   tmux_session.sh
#!/bin/bash


# Название сессии
SESSION_NAME="Work"

# Создание новой tmux сессии в фоне
tmux new-session -d -s $SESSION_NAME

# Окно 1: Запуск команды htop
tmux rename-window -t $SESSION_NAME:0 'CMD'

# Окно 2: Создание вертикального сплита и запуск команды tail -f /var/log/syslog
tmux split-window -h -t $SESSION_NAME:0

# Окно 3: Создание горизонтального сплита и запуск команды bash
tmux split-window -v -t $SESSION_NAME:0.1
tmux send-keys -t $SESSION_NAME:0.2 'pwsh' C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.2 './exc.ps1' C-m

# Переключение на основное окно
tmux select-pane -t $SESSION_NAME:0.0

# Атач к сессии
tmux attach-session -t $SESSION_NAME

