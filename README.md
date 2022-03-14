##простой пример для компиляции приложения в docker контейнере 


## 1 создаем сборочный образ!
    
образ от которого собираемся, должна быть целевая платформа 

    FROM ${DOCKER_REGISTRY_MIRROR}ubuntu:20.04 AS builder

ставим библиотеки и выполняем операции, необходимые при сборке ! 

    RUN  ... (пример описан в DockerFile )

здесь указываем действия после запуска. 

    ENTRYPOINT  ...

создаем сборочный ОБРАЗ c именем  cpp_builder такой командой 

    docker build -t cpp_builder ./path/to/dockerfile


создаем сборочный контейнер и монтируем к нему директории с сиходными файлами 

    docker run build-test --mount type=bind,source="$(pwd)"/scr_example,target=/scr cpp_builder

имя build-test
директория на хосте - source
директория в контейнере target

контейнер останется висесть в системе, и потом его можно запускать 
такой командой. 

    docker start build-test

проверить его статус можно 

    docker ps-a
