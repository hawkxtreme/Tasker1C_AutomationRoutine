﻿
#Область ФормированиеСпискаБаз

Процедура ОбновитьСписокБаз(Данные) Экспорт
	
	МассивСсылок = Новый Массив;
	
	Для Каждого ЭлементСоответствия Из Данные.СоответствиеДанных Цикл

		ДополнительныеДанные = Новый Структура();
		ДополнительныеДанные.Вставить("МассивСсылок", Новый Массив);
		ДополнительныеДанные.Вставить("СоответствиеДанных", Данные.СоответствиеДанных);
		ДополнительныеДанные.Вставить("Параметры", Данные.Параметры);
		ДополнительныеДанные.Вставить("Режимы", Данные.Режимы);
		
		ЭтоГруппа = ЭлементСоответствия.Значение.Connect = Неопределено;
		
		Если ЭтоГруппа Тогда
			ОбновитьГруппу(ЭлементСоответствия.Значение.Name, ЭлементСоответствия.Значение, ДополнительныеДанные);
		Иначе
			ОбновитьИнформационнуюБазу(ЭлементСоответствия.Значение.Name, ЭлементСоответствия.Значение, ДополнительныеДанные);
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивСсылок, ДополнительныеДанные.МассивСсылок);
		
	КонецЦикла;
	
	ПометитьНаУдалениеНеИспользуемыеИнформационныеБазы(МассивСсылок);
	
КонецПроцедуры

Процедура ОбновитьГруппу(Имя, Данные, ДополнительныеДанные)
	
	Если Имя <> "Информационная база" Тогда
		
		Владелец		= Пользователи.ТекущийПользователь();
		Родитель 		= Данные.Folder;
		Родитель 		= СтрЗаменить(Родитель, "/", "");
		РодительСсылка 	= Справочники.Ар_ИнформационныеБазы.ПустаяСсылка();
		ДанныеРодителя	= ПолучитьДанныеСоответствияПоИмениБазы(ДополнительныеДанные.СоответствиеДанных, Родитель);
		
		ГруппаСсылка 	= Справочники.Ар_ИнформационныеБазы.НайтиПоРеквизиту("УникальныйИдентификатор", Данные.ID, , Владелец);
		
		Если ЗначениеЗаполнено(Родитель) Тогда
			ОбновитьГруппу(Родитель, ДанныеРодителя, ДополнительныеДанные);
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Родитель) Тогда
			РодительСсылка = Справочники.Ар_ИнформационныеБазы.НайтиПоРеквизиту("УникальныйИдентификатор", ДанныеРодителя.ID, , Владелец);
		КонецЕсли;
		
		Если ГруппаСсылка.Пустая() Тогда
			
			ОбъектГруппа 							= Справочники.Ар_ИнформационныеБазы.СоздатьГруппу();
			ОбъектГруппа.Владелец 					= Владелец;
			ОбъектГруппа.Родитель					= РодительСсылка;
			ОбъектГруппа.УникальныйИдентификатор    = Данные.ID;
			ОбъектГруппа.Наименование				= Имя;
			ОбъектГруппа.Записать();
			
			ДополнительныеДанные.МассивСсылок.Добавить(ОбъектГруппа.Ссылка);
			
		Иначе
			
			ОбъектГруппа 							= ГруппаСсылка.ПолучитьОбъект();
			ОбъектГруппа.УстановитьПометкуУдаления(Ложь);
			ОбъектГруппа.Родитель					= РодительСсылка;
			ОбъектГруппа.Наименование				= Имя;
			ОбъектГруппа.Записать();
			
			ДополнительныеДанные.МассивСсылок.Добавить(ГруппаСсылка);
			
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

Процедура ОбновитьИнформационнуюБазу(Имя, Данные, ДополнительныеДанные)
	
	Режим			= ДополнительныеДанные.Параметры.Режим;
	Владелец		= Пользователи.ТекущийПользователь();
	Родитель 		= Данные.Folder;
	Родитель 		= СтрЗаменить(Родитель, "/", "");
	РодительСсылка 	= Справочники.Ар_ИнформационныеБазы.ПустаяСсылка();
	ДанныеРодителя	= ПолучитьДанныеСоответствияПоИмениБазы(ДополнительныеДанные.СоответствиеДанных, Родитель);
	
	БазаСсылка 	= Справочники.Ар_ИнформационныеБазы.НайтиПоРеквизиту("УникальныйИдентификатор", Данные.ID, , Владелец);
	
	Если ЗначениеЗаполнено(Родитель) Тогда
		ОбновитьГруппу(Родитель, ДанныеРодителя, ДополнительныеДанные);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Родитель) Тогда
		РодительСсылка = Справочники.Ар_ИнформационныеБазы.НайтиПоРеквизиту("УникальныйИдентификатор", ДанныеРодителя.ID, , Владелец);
	КонецЕсли;
	
	Если БазаСсылка.Пустая() Тогда
		
		Объект 							= Справочники.Ар_ИнформационныеБазы.СоздатьЭлемент();
		Объект.Владелец 				= Владелец;
		Объект.Родитель					= РодительСсылка;
		Объект.УникальныйИдентификатор	= Данные.ID;
		Объект.Наименование				= Имя;
		
		ОбновитьПараметизируемыеРеквизитыИнформационнойБазы(Объект, Данные, ДополнительныеДанные.Режимы.ОбновитьВсе);
		
		Объект.Записать();
		
		ДополнительныеДанные.МассивСсылок.Добавить(Объект.Ссылка);
		
	Иначе
		
		Объект 							= БазаСсылка.ПолучитьОбъект();
		Объект.УстановитьПометкуУдаления(Ложь);
		Объект.Родитель					= РодительСсылка;
		Объект.Наименование				= Имя;
		
		ОбновитьПараметизируемыеРеквизитыИнформационнойБазы(Объект, Данные, Режим);
		
		Объект.Записать();
		
		ДополнительныеДанные.МассивСсылок.Добавить(БазаСсылка);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбновитьПараметизируемыеРеквизитыИнформационнойБазы(Объект, Данные, Режим)
	
	//Connect
	Если СтрНайти(Данные.Connect, "File") > 0 Тогда
		
		НомерСимвола								= СтрНайти(Данные.Connect, "File");
		Объект.ТипРасположенияИнформационныйБазы 	= Перечисления.Ар_ТипыРасположенияИнформационныйБазы.НаДанномКомпьютереИлиНаКомпьютереВЛокальнойСети;
		Объект.КаталогИнформационнойБазы			= Сред(Данные.Connect, НомерСимвола);
		Объект.КаталогИнформационнойБазы			= СтрЗаменить(Объект.КаталогИнформационнойБазы, "File=""", "");
		Объект.КаталогИнформационнойБазы			= СтрЗаменить(Объект.КаталогИнформационнойБазы, """;", "");
		
	ИначеЕсли СтрНайти(Данные.Connect, "Srvr") > 0 Тогда
		
		Объект.ТипРасположенияИнформационныйБазы 	= Перечисления.Ар_ТипыРасположенияИнформационныйБазы.НаСервере1СПредприятия;
		НомерСимволаSrvr							= СтрНайти(Данные.Connect, "Srvr");
		НомерСимволаRef								= СтрНайти(Данные.Connect, "Ref");
		Объект.КластерСерверов						= Сред(Данные.Connect, НомерСимволаSrvr, НомерСимволаRef - НомерСимволаSrvr);
		Объект.КластерСерверов						= СтрЗаменить(Объект.КластерСерверов, "Srvr=""", "");
		Объект.КластерСерверов						= СтрЗаменить(Объект.КластерСерверов, """;", "");
		Объект.ИмяИнформационнойБазы				= Сред(Данные.Connect, НомерСимволаRef);
		Объект.ИмяИнформационнойБазы				= СтрЗаменить(Объект.ИмяИнформационнойБазы, "Ref=""", "");
		Объект.ИмяИнформационнойБазы				= СтрЗаменить(Объект.ИмяИнформационнойБазы, """;", "");
		
	ИначеЕсли СтрНайти(Данные.Connect, "ws") > 0 Тогда
		
		НомерСимвола								= СтрНайти(Данные.Connect, "ws") + 1;
		Объект.ТипРасположенияИнформационныйБазы 	= Перечисления.Ар_ТипыРасположенияИнформационныйБазы.НаВебСервере;
		Объект.АдресИнформационнойБазы				= Сред(Данные.Connect, НомерСимвола);
		
	КонецЕсли;
	
	//App
	Если Режим = "ОбновитьВсе" Тогда
		
		App = Данные.App;
		
		Если Не ЗначениеЗаполнено(App) Тогда
			App = Данные.DefaultApp;
		КонецЕсли;
		
		Если СтрНайти(Данные.App, "Auto") > 0 Тогда
			Объект.ОсновнойРежимЗапуска = Перечисления.Ар_РежимЗапуска.ВыбиратьАвтоматически;
		ИначеЕсли СтрНайти(Данные.App, "ThinClient") > 0 Тогда
			Объект.ОсновнойРежимЗапуска = Перечисления.Ар_РежимЗапуска.ТонкийКлиент;
		ИначеЕсли СтрНайти(Данные.App, "ThickClient") > 0 Тогда
			Объект.ОсновнойРежимЗапуска = Перечисления.Ар_РежимЗапуска.ТолстыйКлиент;
		Иначе
			Объект.ОсновнойРежимЗапуска = Перечисления.Ар_РежимЗапуска.ВебКлиент;
		КонецЕсли;
		
		//Version
		Version = Данные.Version;
		
		Если Не ЗначениеЗаполнено(Version) Тогда
			Version = Данные.DefaultVersion;
		КонецЕсли;
		
		Объект.Версия1С = Version;
		
		//AdditionalParameters
		Объект.ДополнительныеПараметрыЗапуска = Данные.AdditionalParameters;
		
		//AppArch
		Если ЗначениеЗаполнено(Данные.AppArch) Тогда
			
			Если Данные.AppArch = "x86" Тогда
				Объект.Разрядность = Перечисления.Ар_Разрядность.x86;
			ИначеЕсли Данные.AppArch = "x86_prt" Тогда
				Объект.Разрядность = Перечисления.Ар_Разрядность.x86_Приоритет;
			ИначеЕсли Данные.AppArch = "x86_64" Тогда
				Объект.Разрядность = Перечисления.Ар_Разрядность.x64;
			ИначеЕсли Данные.AppArch = "x86_64_prt" Тогда
				Объект.Разрядность = Перечисления.Ар_Разрядность.x64_Приоритет;
			КонецЕсли;
			
		Иначе
			Объект.Разрядность = Перечисления.Ар_Разрядность.x86;
		КонецЕсли;
		
		//Execute
		Объект.ВнешняяОбработка = Данные.Execute;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПометитьНаУдалениеНеИспользуемыеИнформационныеБазы(МассивСсылок)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	Ар_ИнформационныеБазы.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Ар_ИнформационныеБазы КАК Ар_ИнформационныеБазы
		|ГДЕ
		|	Ар_ИнформационныеБазы.Владелец = &Владелец
		|	И НЕ Ар_ИнформационныеБазы.Ссылка В (&МассивСсылок)";
	
	Запрос.УстановитьПараметр("Владелец", Пользователи.ТекущийПользователь());
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		ОбъектИБ = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
		ОбъектИБ.УстановитьПометкуУдаления(Истина);
		
	КонецЦикла;
		
КонецПроцедуры

Функция ПолучитьДанныеСоответствияПоИмениБазы(СоответствиеДанных, Имя)
	
	Результат = Неопределено;
	
	Для Каждого ЭлементСоответствия Из СоответствиеДанных Цикл
		
		Если ЭлементСоответствия.Значение.Name = Имя Тогда
			Результат = ЭлементСоответствия.Значение;
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат
	
КонецФункции

#КонецОбласти

#Область ФормированиеДанныхДляКоманд

Функция ПолучитьДанныеФормированияКоманды(ИнформационнаяБаза, Режим) Экспорт
	Возврат Справочники.Ар_ИнформационныеБазы.ПолучитьДанныеВыполненияКомандыКонфигурации(ИнформационнаяБаза, Режим);
КонецФункции

#КонецОбласти

#Область Кластер

Функция ПолучитьПараметрыКластера(ИнформационнаяБаза, ДополнительныеДанные = Неопределено) Экспорт
	Возврат Ар_ИнформационныеБазы.ПолучитьПараметрыКластера(ИнформационнаяБаза, ДополнительныеДанные);
КонецФункции

Функция СвойстваБлокировокИнформационнойБазы(ПараметрыКластера, ПараметрыИБ) Экспорт
	Возврат АдминистрированиеКластера.БлокировкаСеансовИЗаданийИнформационнойБазы(ПараметрыКластера, ПараметрыИБ);
КонецФункции

Процедура УстановитьБлокировкуРегламентныхЗаданийИнформационнойБазы(ПараметрыКластера, ПараметрыИБ, Значение) Экспорт
	АдминистрированиеКластера.УстановитьБлокировкуРегламентныхЗаданийИнформационнойБазы(ПараметрыКластера, ПараметрыИБ, Значение)
КонецПроцедуры

Процедура УстановитьБлокировкуСеансовИЗаданийИнформационнойБазы(ПараметрыКластера, ПараметрыИБ, Данные) Экспорт
	АдминистрированиеКластера.УстановитьБлокировкуСеансовИЗаданийИнформационнойБазы(ПараметрыКластера, ПараметрыИБ, Данные)
КонецПроцедуры

Функция СеансыИнформационнойБазы(ПараметрыКластера, ПараметрыИБ) Экспорт
	Возврат АдминистрированиеКластера.СеансыИнформационнойБазы(ПараметрыКластера, ПараметрыИБ)
КонецФункции

Процедура УдалитьСеансыИнформационнойБазы(ПараметрыКластера, ПараметрыИБ, Фильтр = Неопределено) Экспорт
	АдминистрированиеКластера.УдалитьСеансыИнформационнойБазы(ПараметрыКластера, ПараметрыИБ, Фильтр)
КонецПроцедуры

Функция СоединенияСИнформационнойБазой(ПараметрыКластера, ПараметрыИБ) Экспорт
	Возврат АдминистрированиеКластера.СоединенияСИнформационнойБазой(ПараметрыКластера, ПараметрыИБ)
КонецФункции

Процедура РазорватьСоединенияСИнформационнойБазой(ПараметрыКластера, ПараметрыИБ, Фильтр = Неопределено) Экспорт
	АдминистрированиеКластера.РазорватьСоединенияСИнформационнойБазой(ПараметрыКластера, ПараметрыИБ, Фильтр)
КонецПроцедуры

#КонецОбласти

#Область Общее

Функция ПолучитьДанныеКонфигурации(ИнформационнаяБаза) Экспорт
	Возврат Справочники.Ар_ИнформационныеБазы.ПолучитьДанныеКонфигурации(ИнформационнаяБаза);
КонецФункции

#КонецОбласти

