﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Для Каждого ИнформационнаяБаза Из ПараметрКоманды Цикл
		Ар_ИнформационныеБазыКлиент.УстановитьБлокировкуСеансовИЗаданий(ПараметрыВыполненияКоманды.Источник, ИнформационнаяБаза);
	КонецЦикла;
КонецПроцедуры
