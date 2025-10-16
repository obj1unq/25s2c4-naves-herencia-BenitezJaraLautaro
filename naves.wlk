class nave {
	var property velocidad = 0
	var property name = 
}

class NaveDeCarga {

	var velocidad = 0
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros {

	var velocidad = 0
	var property alarma = false
	const cantidadDePasajeros = 0

	method cantiPersonasABordo() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.cantiPersonasABordo() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate {
	var property velocidad = 0
	var property modo = reposo
	const property mensajesEmitidos = []
	var armasDesplegadas = false

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = modo.estaInvisible(self)

	method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	method tieneArmasDesplegadas() {
		return armasDesplegadas 
	  
	}

	method desplegarArmas() {
		armasDesplegadas = true
	  
	}

}

object reposo {

	method invisible() = false

	method estaInvisible(nave) {
		return nave.velocidad() < 10000
	  
	}

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method estaInvisible(nave) {
		return not nave.tieneArmasDesplegadas()
	  
	}

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
		nave.desplegarArmas()
	}

}
