Класс Auth

get
Получает ключ авторизации с сервиром izkh.

Класс check_email

get_reports
Ищет на почте system@izkh.ru выгрузки от поставщиков за текущий день по email и добавляет их в папку report/#{DateTime.now.month}-#{DateTime.now.year}/#{filename}. Название файла соотвествует названию организации.

get_organizations
Ищет на почте ivanova@izkh.ru выгрузки от менеджеров за текущий день по теме файла "Organozations" и добавляет их в папку organizations. К названию файла присывается год-месяц-день.







