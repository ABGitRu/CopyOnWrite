//: [Previous](@previous)

import Foundation

func print(address o: UnsafeRawPointer ) {
	print(String(format: "%p", Int(bitPattern: o)))
}

var array1: [Int] = [0, 1, 2, 3]
var array2 = array1

//Передадим в консоль только текущие объекты
print(address: array1) //0x600002b10020
print(address: array2) //0x600002b10020
//Теперь давайте попробуем изменить второй объект
//И посмотрим изменился ли его адрес
array2.append(4)

print(address: array2) //0x60000263d4c0

//Что вывелось в консоль
//0x600002b10020 array1 адрес
//0x600002b10020 array2 адрес до изменения
//0x60000263d4c0 array2 адрес после изменения

//: [Next](@next)
