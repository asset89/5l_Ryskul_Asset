//
//  main.swift
//  5l_Ryskul_Asset
//
//  Created by Asset Ryskul on 18.11.2021.
//

// MARK: - Перечисление состояние окон
enum WindowState: String {
    case open = "Окна открыты"         // открыто
    case close = "Окна закрыты"        // закрыто
}
// MARK: - Перечисление состояние двигателя
enum EngineState: String{
    case start = "Двигатель заведен"          // включен
    case stop = "Двигатель выключен"          // заглушен
}
// MARK: - Перечисление описывающее погрузку/выгрузку из кузова/багажника
enum TrunkStateFill {
    case fill_in        // погрузить
    case fill_of        // выгрузить
}

// MARK: - Протокол Car для общего описания автомашин
protocol Car: CustomStringConvertible {
    /*-- Свойства --*/
    var model: String { get }                // модель
    var releaseYear: Int { get }             // год выпуска
    var windowState: WindowState { get set }    // состояние окон
    var engineState: EngineState { get set }   // состояние двигателя
    
    /*-- Метод, который выводит надпись о движении автомашины --*/
    func drive()
    
    /*-- Метод для вывода свойства description протокола CustomStringConvertible--*/
    func printDescription()
}



// MARK: - Класс для спортивной машины
class SportCar: Car {
    
    var model: String
    
    var releaseYear: Int
    
    var windowState: WindowState
    
    var engineState: EngineState
    
    var description: String {
        return "Модель спорткара: \(self.model), год выпуска: \(self.releaseYear), макс.скорость \(self.maxSpeed) км/ч"
        }
    
    // свойство SportCar, максимальная скорость
    var maxSpeed: Int
    
    /*-- Инициализация класса --*/
    init(model: String, releaseYear: Int, windowState: WindowState, engineState: EngineState, maxSpeed: Int) {
        self.model = model
        self.releaseYear = releaseYear
        self.windowState = windowState
        self.engineState = engineState
        self.maxSpeed = maxSpeed
    }

    
    func drive() {
        print("Спортивный автомобиль марки \(self.model) тронулся!")
    }
}

// MARK: - Структура для грузовой машины
class TrunkCar: Car {

    var model: String
    
    var releaseYear: Int
    
    var windowState: WindowState
    
    var engineState: EngineState
    
    var description: String {
        return "Модель грузовика: \(self.model), год выпуска: \(self.releaseYear), обьем заполненного груза \(self.trunkVolume) л"
        }
    
    // свойство TrunkCar, обьем кузова
    var trunkVolume: Double

    /*-- Конструктор --*/
    init(model: String, releaseYear: Int, windowState: WindowState, engineState: EngineState, trunkVolume: Double) {
        self.model = model
        self.releaseYear = releaseYear
        self.windowState = windowState
        self.engineState = engineState
        self.trunkVolume = trunkVolume
    }
    
    func drive() {
        print("Грузовик марки \(self.model) тронулся!")
    }
        
    /*-- Метод для погрузки/выгрузки из кузова/багажника груза с определенным обьемом --*/
    func fill_to_trunk(fill state: TrunkStateFill, capacity volume: Double) {
        switch state {
            case .fill_in:
                self.trunkVolume += volume
                print("Загружено в кузов груз обьемом в \(volume) л/кг*3, заполнено \(self.trunkVolume) л/кг*3 обьема")
            case .fill_of:
                self.trunkVolume -= volume
                print("Выгружено из кузова груз обьемом в \(volume) л/кг*3б , еще свободно \(self.trunkVolume) л/кг*3 обьема")
        }
    }
}

// MARK: - Расширение протокола Car с методами windowControl & engineControl
extension Car {
    /*-- Метод для открытия/закрытия окон --*/
    mutating func windowControl(_ state: WindowState) {
        self.windowState = state
        switch self.windowState {
            case .open:
                print(state.rawValue)
            case .close:
                print(state.rawValue)
        }
    }
    
    /*-- Метод для запуска/выключения двигателя --*/
    mutating func engineControl(_ state: EngineState) {
        self.engineState = state
        switch self.engineState {
            case .start:
                print(state.rawValue)
            case .stop:
                print(state.rawValue)
        }
    }
    
    func printDescription() {
        print(description)
    }
}

// MARK: - создаем обьекты классов SportCar и TrunkCar
/*--- обьект спортивного автомобиля ---*/
var sportCar = SportCar(model: "Nissan Skyline", releaseYear: 2020, windowState: .close, engineState: .start, maxSpeed: 300)
sportCar.printDescription()
sportCar.drive()
sportCar.engineControl(.stop)
sportCar.windowControl(.open)
print(sportCar.windowState)


print("\n")
/*--- обьект грузового автомобиля ---*/
var trunk = TrunkCar(model: "Kamaz", releaseYear: 2015, windowState: .open, engineState: .stop, trunkVolume: 50)

trunk.printDescription()
print(trunk.windowState.rawValue)
trunk.drive()
trunk.engineControl(.stop)
trunk.windowControl(.close)
trunk.fill_to_trunk(fill: .fill_in, capacity: 50)
print(trunk.windowState.rawValue)
