//: [Previous](@previous)

import Foundation

// класс который наши объекты будут шейрить между собой при первой инициализации
class Ref<T> {
  var val : T
  init(_ v : T) {val = v}
}

// обертка над нашим обьектом который мы хотим обучить использовать Copy on Write
struct Box<T> {
	var ref : Ref<T>
	init(_ x : T) { ref = Ref(x) }

	var value: T {
		get {
			return ref.val }
		set {
			// проверяем есть ли еще какие то ссылки указывающие на наш объект
			guard isKnownUniquelyReferenced(&ref) else {
				print("more than 1 strong link")
				ref = Ref(newValue)
				return
			}
		  ref.val = newValue
		}
	}
}

// Создаем объект который будет иметь возможность копирования при записии
struct Sample {
	var num: Int
}

let sample = Sample(num: 1)

// Оборачиваем его в нашу обертку
var number = Box(sample)
// Создаем второй объект и просим его присвоить ему number
var secondNumber = number

// в данный момент оба наших объекта для обращения к value указывают на один и тот же ref
// здесь работает первая часть copy on write,
// мы еще не создали для secondNumber своей полноценной копии
number.ref === secondNumber.ref

// здесь мы попадаем во вторую часть copy on write мутируя один из наших объектов
// после такого события наш второй объект будет иметь свою собственную уже уникальную ссылку на ref
secondNumber.value.num += 24

// проверяем работает ли наше утверждение и видим что ref действительно уникален
number.ref === secondNumber.ref

// и разумеется num как одного так и другого обьекта разный
number.value.num == secondNumber.value.num
number.value.num
secondNumber.value.num


//: [Next](@next)
