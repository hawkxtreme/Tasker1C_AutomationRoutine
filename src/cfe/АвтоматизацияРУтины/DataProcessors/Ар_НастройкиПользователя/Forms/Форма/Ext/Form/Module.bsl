﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Пользователь = Пользователи.ТекущийПользователь();
	
	Если Не Пользователь.Пустая() Тогда
		
		ДанныеПользователя = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Пользователь, "Ар_ИспользоватьИнформационныеБазы");
		
		Объект.ИспользоватьИнформационныеБазы = ДанныеПользователя.Ар_ИспользоватьИнформационныеБазы;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьИнформационныеБазыПриИзменении(Элемент)
	ИспользоватьИнформационныеБазыПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ИспользоватьИнформационныеБазыПриИзмененииНаСервере()
	ОбновитьПользователяНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбновитьПользователяНаСервере()
	
	Если Не Пользователь.Пустая() Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		
		ОбъектПользователя = Пользователь.ПолучитьОбъект();
		ОбъектПользователя.Ар_ИспользоватьИнформационныеБазы = Объект.ИспользоватьИнформационныеБазы;
		
		ОбъектПользователя.Записать();
		
		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЕсли;
	
КонецПроцедуры

