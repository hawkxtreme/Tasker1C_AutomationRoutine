﻿
#Область ДействияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ИнициализироватьНаСервере(Отказ, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ИнициализироватьНаКлиенте(Отказ);
КонецПроцедуры

#КонецОбласти

#Область ДействияЭлементовФормы

#КонецОбласти

#Область Команды

#КонецОбласти

#Область Заполнение

&НаСервере
Процедура ИнициализироватьНаСервере(Отказ, СтандартнаяОбработка)
	ИзменитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ИнициализироватьНаКлиенте(Отказ)
	ОбновитьСписокБазНаКлиенте();
КонецПроцедуры

&НаСервере
Процедура ИзменитьВидимостьНаСервере()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "ПометкаУдаления", Ложь,
		ВидСравненияКомпоновкиДанных.Равно, , Истина, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Владелец", Пользователи.ТекущийПользователь(),
		ВидСравненияКомпоновкиДанных.Равно, , Истина, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Конфигурация", ,
		ВидСравненияКомпоновкиДанных.Равно, , Ложь, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСписокБазНаКлиенте()
	Ар_СписокБазКлиент.ОбновитьСписокБаз();
	Элементы.Список.Обновить();
КонецПроцедуры

#КонецОбласти

#Область Общее

#КонецОбласти
