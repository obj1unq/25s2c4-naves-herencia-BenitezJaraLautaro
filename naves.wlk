class Nave {
	var  velocidad = 0
	
	method propulsar() {
		velocidad = (velocidad+20000).min(300000)
	}

	method velocidad() {
	  return velocidad
	}

	method prepararseParaViajar() {
		velocidad = (velocidad + 15000).min(300000)
	  
	}
}

class NaveDeCarga inherits Nave {

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros inherits Nave{

	var property alarma = false
	const cantidadDePasajeros = 0

	method cantiPersonasABordo() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.cantiPersonasABordo() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave{
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

	override method prepararseParaViajar() {
		super()
		modo.preparaParaViajar(self)
	  
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

	method preparaParaViajar(nave) {
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)
	  
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

	method preparaParaViajar(nave) {
		nave.emitirMensaje("Volviendo a la base")
	  
	}

}

class NaveCargaResiduosRadiactivos inherits NaveDeCarga {
	var selladoAlVacio = false

	override method  recibirAmenaza() {
		if (selladoAlVacio) {
			velocidad = 0
		} else {
			super()
		}
	  
	}

	override method prepararseParaViajar() {
		super()
		selladoAlVacio = true
	}

}


