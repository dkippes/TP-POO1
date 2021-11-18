!classDefinition: #SistemaDeArchivosTest category: 'Grupo1-TP-Final'!
TestCase subclass: #SistemaDeArchivosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!SistemaDeArchivosTest methodsFor: 'sistemaDeArchivos_testing' stamp: 'TC 11/15/2021 23:54:54'!
test001_cuandoUnaCarpetaEsCreada_EstaTieneUnNombre_UnaListaDeArchivos_UnaListaDeCarpetas_UnaFechaDeCreacionYUnaFechaDeModificacion

	"Setup"
	| unaCarpetaNueva  unaFechaDeCreacion |
	
	unaCarpetaNueva _ Folder conNombre: 'root'.
	unaFechaDeCreacion _ FixedGregorianDate today.

	Assert that: unaCarpetaNueva nombre isEqualTo: 'root'.
	Assert isFalse: (unaCarpetaNueva tieneCarpetas).
	Assert isFalse: (unaCarpetaNueva tieneArchivos). 
	Assert that: unaCarpetaNueva fechaDeCreacion isEqualTo: unaFechaDeCreacion.
	Assert that: unaCarpetaNueva fechaDeModificacion isEqualTo: unaFechaDeCreacion.! !

!SistemaDeArchivosTest methodsFor: 'sistemaDeArchivos_testing' stamp: 'TC 11/15/2021 23:52:21'!
test002_cuandoUnArchivoSeCrea_EsteTieneNombre_UnaFechaDeCreacionYUnaFechaDeModificacion
	"Setup"
	| unArchivoNuevo unaFechaDeCreacion |
	
	unArchivoNuevo _ File conNombre: 'Archivo1.txt'.
	unaFechaDeCreacion _ FixedGregorianDate today.
	
	Assert that: unArchivoNuevo nombre isEqualTo: 'Archivo1.txt'.
	Assert that: unArchivoNuevo fechaDeCreacion isEqualTo: unaFechaDeCreacion.
	Assert that: unArchivoNuevo fechaDeModificacion isEqualTo: unaFechaDeCreacion.! !


!classDefinition: #TerminalTest category: 'Grupo1-TP-Final'!
TestCase subclass: #TerminalTest
	instanceVariableNames: 'unUserRootDefault unUserRootDiego1234 unUserRootDiego4321 unUserPublicDiego4321 carpetaTomas carpetaDiego archivoDeTexto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 21:01:26'!
errorContraseñaOUsuarioIncorrecto

	^ 'El nombre y/o contraseña es incorrecta'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 21:01:19'!
errorUsuarioNoExistente

	^ 'El usuario no existe'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 20:45:57'!
unaTerminalConUnUsuarioRootDefaultLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	^ unaTerminal .! !


!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:02:33'!
errorNoSePuedeRetrocederDesdeRoot

	^ 'No se puede volver, estas parado en root'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:59:36'!
errorPorCarpetaInexistente

	^ 'La carpeta no existe en este directorio'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:07:07'!
errorPorCrearUnArchivoConElMismoNombreEnElDirectorio

	^ 'No se puede crear un archivo con el mismo nombre'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:17:12'!
test001_cuandoUnaTerminalSeCrea_iniciaSesionUnUsuarioRoot

	"Setup"
	| terminal unUsuarioRoot |
	unUsuarioRoot _ RootUser conNombre: 'root' yContraseña: 'root' .
	terminal _ Terminal iniciarSesion: unUsuarioRoot .
	
	Assert isTrue: (terminal tieneAlUsuarioLogueado: unUsuarioRoot) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:22:09'!
test002_cuandoUnaTerminalSeCrea_unUsuarioRoot_registraUnUsuario_esteIniciaSesion

	"Setup"
	| unUsuarioLogueado unaTerminal |
	unUsuarioLogueado _ PublicUser conNombre: 'Diego' yContraseña: '1234' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioLogueado en: unaTerminal .
	unaTerminal iniciarSesion: unUsuarioLogueado .
	
	Assert isTrue: (unaTerminal tieneAlUsuarioLogueado: unUsuarioLogueado) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:22:55'!
test003_cuandoUnaTerminalSeCrea_unUsuarioTrataDeLoguearseInsactifactoriamente

	"Setup & Exercise"
	| unUserInexistente |
	unUserInexistente _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserInexistente]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:23:28'!
test004_cuandoUnaTerminalSeCrea_unUsuarioRootTrataDeLoguearseInsactifactoriamente

	"Setup"
	| unUserRootInexistente |
	unUserRootInexistente _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserRootInexistente ]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:48:04'!
test005_cuandoUnaTerminalSeCrea_unUsuarioRoot_registraUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isTrue: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:50:00'!
test006_cuandoUnaTerminalSeCrea_unUsuarioRoot_borraUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	unUserRootDefault borrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isFalse: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:51:10'!
test007_cuandoUnaTerminalSeCrea_unUsuarioRoot_noPuedeAgregarUnUsuarioYaExistente

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert
        should: [ unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .  ]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:51:33'!
test008_cuandoUnaTerminalSeCrea_unUsuarioRoot_trataDeBorraUnUsuarioInexistente

	"Setup"
	| terminal |
	terminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	Assert
        should: [ unUserRootDefault borrarUsuario: unUserPublicDiego4321 en: terminal  ]
        signal: Error
        withDescription: self errorUsuarioNoExistente .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:52:52'!
test009_cuandoUnaTerminalSeCrea_unUsuarioRoot_modificaUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar unUsuarioModificado |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unUsuarioModificado _ PublicUser conNombre: 'Tomas' yContraseña: '9876' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	unUserRootDefault modificarUsuario: unUsuarioAAgregar por: unUsuarioModificado en: unaTerminal .
	
	Assert isFalse: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:53:17'!
test010_cuandoUnaTerminalSeCrea_unUsuarioRoot_noPuedeModificarUsuarioInexistente

	"Setup"
	| unaTerminal unUsuarioAAgregar unUsuarioModificado |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unUsuarioModificado _ PublicUser conNombre: 'Tomaz' yContraseña: '9876' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	Assert
        should: [ unUserRootDefault modificarUsuario: unUsuarioAAgregar por: unUsuarioModificado en: unaTerminal  ]
        signal: Error
        withDescription: self errorUsuarioNoExistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:53:59'!
test011_cuandoUnUsuarioIniciaSesion_esteEstaParadoEnLaCarpetaRoot

	"Setup"
	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
		
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:57:55'!
test012_cuandoUnUsuarioEscribeMkDirEnLaTerminal_creaUnaCarpetaEnElDirectorio

	"Setup"
	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Exersice" 
	unaTerminal mkdir: carpetaTomas .

	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert isTrue: (unaTerminal tieneCarpetasEnElDirectorioActual).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:58:18'!
test013_cuandoUnUsuarioEscribeMkDirEnLaTerminal_noPuedeCrearUnaCarpetaYaExistente

	| unaTerminal unaCarpetaNueva |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaNueva _ carpetaTomas .

	"Exersice" 
	unaTerminal mkdir: unaCarpetaNueva .
	unaTerminal cd: unaCarpetaNueva .

	"Assert"
	Assert isFalse: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert that: (unaTerminal carpetaActual) isEqualTo: unaCarpetaNueva .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:59:36'!
test014_cuandoUnUsuarioEscribeCDEnLaTerminal_noPuedeIngresarAUnaCarpetaInexistente

	| unaTerminal unaCarpeta |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpeta _ carpetaTomas .

	"Assert"
	Assert
        should: [unaTerminal cd: unaCarpeta .]
        signal: Error
        withDescription: self errorPorCarpetaInexistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:00:29'!
test015_cuandoUnUsuarioEscribeCDParaVolverEnLaTerminal_esteVuelveUnaCarpetaHaciaAtras

	| unaTerminal unaCarpetaNueva otraCarpetaNueva |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaNueva _ carpetaTomas .
	otraCarpetaNueva _ carpetaDiego .

	"Exersice" 
	unaTerminal mkdir: unaCarpetaNueva .
	unaTerminal cd: unaCarpetaNueva .
	unaTerminal mkdir: otraCarpetaNueva .
	unaTerminal cd: otraCarpetaNueva .
	unaTerminal cd .

	"Assert"
	Assert isFalse: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert that: (unaTerminal carpetaActual) isEqualTo: unaCarpetaNueva .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:02:33'!
test016_cuandoUnUsuarioEscribeCDParaVolverEnLaTerminal_esteNoPuedeRegresarALaCarpetaAnterior_porEstarEnElDirectorioRoot

	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cd .]
        signal: Error
        withDescription: self errorNoSePuedeRetrocederDesdeRoot .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:01:31'!
test017_cuandoUnUsuarioIngresaAVariasCarpetas_esteLuegoRegresaARoot

	| unaTerminal otraCarpetaDiego unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ carpetaTomas .
	otraCarpetaDiego _ carpetaDiego .

	"Exersice"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
	unaTerminal mkdir: otraCarpetaDiego .
	unaTerminal cd: otraCarpetaDiego .
	unaTerminal cd .
	unaTerminal cd .
	
	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 17:34:39'!
test018_cuandoUnUsuarioIngresaAVariasCarpetas_esteSePosicionaEnRoot

	| unaTerminal otraCarpetaDiego unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ carpetaTomas .
	otraCarpetaDiego _ carpetaDiego .

	"Exersice"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
	unaTerminal mkdir: otraCarpetaDiego .
	unaTerminal cd: otraCarpetaDiego .
	unaTerminal cd . 
	unaTerminal cd .
	
	"Assert"
	Assert
        should: [unaTerminal cd .]
        signal: Error
        withDescription: self errorNoSePuedeRetrocederDesdeRoot .
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:06:15'!
test019_cuandoUnUsuarioEscribeElComandoTouch_esteCreaUnArchivo

	| unaTerminal unArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoNuevo _ File conNombre: 'Archivo1.txt' .
	
	"Exercise"
	unaTerminal touch: unArchivoNuevo.
	
	"Assert"
	Assert isTrue: (unaTerminal tieneElArchivoEnElDirectorioActual: unArchivoNuevo).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:08:13'!
test020_cuandoUnUsuarioCreaUnArchivo_noPuedeCrearloPorque_esteYaExisteEnElDirectorioActual

	| unaTerminal unArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoNuevo _ archivoDeTexto .
	
	"Exercise"
	unaTerminal touch: unArchivoNuevo.
	
	"Assert"
	Assert
        should: [unaTerminal touch: unArchivoNuevo.]
        signal: Error
        withDescription: self errorPorCrearUnArchivoConElMismoNombreEnElDirectorio .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:08:36'!
test021_cuandoUnUsuarioListaElContenidoDelDirectorio_conElComandoLS_esteListaTodosLosArchivosYLasCarpetas

	| unaTerminal unArchivoDeTexto unaCarpetaNueva listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoDeTexto _ archivoDeTexto .
	unaCarpetaNueva _ Folder conNombre: 'Diego'.
	listaDeArchivosYCarpetas _ Set new.
	listaDeArchivosYCarpetas add: unArchivoDeTexto.
	listaDeArchivosYCarpetas add: unaCarpetaNueva.
	
	"Exercise"
	unaTerminal touch: unArchivoDeTexto.
	unaTerminal mkdir: unaCarpetaNueva.
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:09:10'!
test022_cuandoUnUsuarioListaElContenidoDelDirectorio_conElComandoLS_noTieneNadaEnElDirectorioActual

	| unaTerminal listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	listaDeArchivosYCarpetas _ Set new.

	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:09:50'!
test023_cuandoUnUsuarioBorraUnArchivo_conElComandoRM_esteSeBorraDelDirectorioActual

	| unaTerminal unaArchivoNuevo listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ archivoDeTexto .
	listaDeArchivosYCarpetas _ Set new.
	
	"Exercise"
	unaTerminal touch: unaArchivoNuevo.
	unaTerminal rm: unaArchivoNuevo.

	"Assert"
	Assert that: unaTerminal ls isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:27:28'!
test024_cuandoUnUsuarioRootLeaUnArchivoDeText_esteMuestraElTexto

	| unaTerminal unaArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ archivoDeTexto .
	
	"Exercise"
	unaTerminal touch: unaArchivoNuevo .
	

	"Assert"
	Assert that: (unaTerminal cat: unaArchivoNuevo)  isEqualTo: ''.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:30:03'!
test025_cuandoUnUsuarioRootLeaUnArchivoDeText_esteNoExisteEnElDirectorioActual

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cat: archivoDeTexto]
        signal: Error
        withDescription: 'El archivo que intenta leer no existe' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:39:29'!
test026_cuandoUnUsuarioRootModifiqueUnArchivoDeTexto_esteReemplazaElTextoExistente

	| unaTerminal unaArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ archivoDeTexto .
	
	"Exercise"
	unaTerminal touch: unaArchivoNuevo .
	unaTerminal nano: unaArchivoNuevo edicion: 'Texto Modificado'.
	

	"Assert"
	Assert that: (unaTerminal cat: unaArchivoNuevo)  isEqualTo: 'Texto Modificado'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:40:21'!
test027_cuandoUnUsuarioRootModifiqueUnArchivoDeTexto_esteNoExiste

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Assert"
	Assert
        should: [unaTerminal nano: archivoDeTexto edicion: 'Texto Modificado']
        signal: Error
        withDescription: 'El archivo que intenta modificar no existe' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/18/2021 00:52:26'!
test028_cuandoUnUsuarioFiltreUnArchivoPorTextoDado_esteMuestra1ArchivosEncontrado

	| unaTerminal unArchivoConElTextoABuscar unArchivoSinTexto listaDeArchivosEncontrados filtros filtrarPorTexto |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoConElTextoABuscar _ archivoDeTexto .
	unArchivoSinTexto _ File conNombre: 'Archivo2.txt'.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: unArchivoConElTextoABuscar .
	filtrarPorTexto _ FilterText conElTexto: 'Texto Modificado'.
	filtros _ Filter filtrarPor: {filtrarPorTexto    }.
	
	"Exercise"
	unaTerminal touch: unArchivoConElTextoABuscar .
	unaTerminal touch: unArchivoSinTexto .
	unaTerminal nano: unArchivoConElTextoABuscar edicion: 'Texto Modificado'.
	
	
	"Assert"
	Assert that: (unaTerminal filtrarCon: filtros) isEqualTo: listaDeArchivosEncontrados .
	! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/18/2021 01:52:38'!
test029_cuandoUnUsuarioFiltreUnArchivoPorTextoDado_esteNoEncuentraResultados

	| unaTerminal unArchivoConElTextoABuscar unArchivoSinTexto listaDeArchivosEncontrados filtrarPorTexto filtros|
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoConElTextoABuscar _ archivoDeTexto .
	unArchivoSinTexto _ File conNombre: 'Archivo2.txt'.
	listaDeArchivosEncontrados _ Set new .
	filtrarPorTexto _ FilterText conElTexto: 'Texto Modificado'.
	filtros _ Filter filtrarPor: {filtrarPorTexto    }.
	
	"Exercise"
	unaTerminal touch: unArchivoConElTextoABuscar .
	unaTerminal touch: unArchivoSinTexto .
	unaTerminal nano: unArchivoConElTextoABuscar edicion: 'Texto'.
	
	"Assert"
	Assert that: (unaTerminal filtrarCon: filtros) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/18/2021 01:49:30'!
test030_cuandoUnUsuarioFiltreUnArchivoPorUnaFechaDeCreacionDada_estaDevuelveUnaColeccionDeArchivos

	| unaTerminal fechaDeCreacion unArchivoSinTexto listaDeArchivosEncontrados filtrarPorDate filtros|
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	fechaDeCreacion _ FixedGregorianDate today.
	unArchivoSinTexto _ File conNombre: 'Archivo2.txt'.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: unArchivoSinTexto.
	filtrarPorDate _ FilterCreationFile conLaFecha: fechaDeCreacion.
	filtros _ Filter filtrarPor: {filtrarPorDate    }.
	
	"Exercise"
	unaTerminal touch: unArchivoSinTexto .
	
	"Assert"
	Assert that: (unaTerminal filtrarCon: filtros) isEqualTo: listaDeArchivosEncontrados.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/18/2021 02:00:11'!
test031_cuandoUnUsuarioCombinaFiltros_estaDevuelveUnaColeccionDeResultadosDeArchivos

	| unaTerminal fechaDeCreacion unArchivoSinTexto unArchivoConElTextoABuscar listaDeArchivosEncontrados filtrarPorDate filtros filtrarPorTexto otroArchivoConElTextoABuscar|
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	fechaDeCreacion _ FixedGregorianDate today.
	unArchivoConElTextoABuscar _ archivoDeTexto .
	unArchivoSinTexto _ File conNombre: 'Archivo2.txt'.
	otroArchivoConElTextoABuscar _ File conNombre: 'Archivo3.txt'.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: unArchivoConElTextoABuscar.
	listaDeArchivosEncontrados add: otroArchivoConElTextoABuscar.
	filtrarPorDate _ FilterCreationFile conLaFecha: fechaDeCreacion.
	filtrarPorTexto _ FilterText conElTexto: 'Texto Modificado'.
	filtros _ Filter filtrarPor: {filtrarPorDate . filtrarPorTexto }.
	
	"Exercise"
	unaTerminal touch: unArchivoConElTextoABuscar. 
	unaTerminal touch: unArchivoSinTexto.
	unaTerminal touch: otroArchivoConElTextoABuscar.
	unaTerminal nano:  unArchivoConElTextoABuscar edicion: 'Texto Modificado' .
	unaTerminal nano:  otroArchivoConElTextoABuscar edicion: 'Texto Modificado' .
	
	"Assert"
	Assert that: (unaTerminal filtrarCon: filtros) isEqualTo: listaDeArchivosEncontrados.! !


!TerminalTest methodsFor: 'setUp/tearDown' stamp: 'dk 11/17/2021 00:03:51'!
setUp

	unUserRootDefault _ RootUser conNombre: 'root' yContraseña: 'root' .
	unUserRootDiego1234 _ RootUser conNombre: 'Diego' yContraseña: '1234' .
	unUserRootDiego4321 _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	unUserPublicDiego4321 _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	
	carpetaTomas _ Folder	 conNombre: 'Tomas' .
	
	carpetaDiego _ Folder	 conNombre: 'Diego' .
	
	archivoDeTexto _ File conNombre: 'Archivo1.txt' .! !


!classDefinition: #File category: 'Grupo1-TP-Final'!
Object subclass: #File
	instanceVariableNames: 'nombre fechaDeCreacion fechaDeModificacion texto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!File methodsFor: 'initialization' stamp: 'dk 11/17/2021 00:28:35'!
initialize

	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.
	
	texto _ '' .! !

!File methodsFor: 'initialization' stamp: 'TC 11/15/2021 23:41:17'!
initializeConNombre: unNombre 
	nombre := unNombre.! !


!File methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:52:39'!
fechaDeCreacion
	^fechaDeCreacion! !

!File methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:52:49'!
fechaDeModificacion
	^fechaDeModificacion! !

!File methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:41:30'!
nombre
	^nombre! !

!File methodsFor: 'accessing' stamp: 'dk 11/17/2021 00:28:15'!
texto
	^ texto! !


!File methodsFor: 'testing' stamp: 'dk 11/17/2021 00:52:07'!
contieneElTexto: unTexto 

	^ texto = unTexto ! !

!File methodsFor: 'testing' stamp: 'TC 11/16/2021 00:11:19'!
nombreEsIgual: nombreArchivo
	^ (nombre = nombreArchivo) ! !


!File methodsFor: 'public actions' stamp: 'dk 11/17/2021 00:39:11'!
modificarTexto: unTexto 
	texto _ unTexto .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'File class' category: 'Grupo1-TP-Final'!
File class
	instanceVariableNames: ''!

!File class methodsFor: 'instance creation' stamp: 'TC 11/15/2021 23:40:45'!
conNombre: unNombre
	
	^self new initializeConNombre: unNombre. ! !


!classDefinition: #Filter category: 'Grupo1-TP-Final'!
Object subclass: #Filter
	instanceVariableNames: 'listaDeFiltros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Filter methodsFor: 'initialization' stamp: 'TC 11/18/2021 00:53:03'!
initializeFiltrarPor: unaListaDeFiltros 
	listaDeFiltros _ unaListaDeFiltros.! !


!Filter methodsFor: 'public actions' stamp: 'TC 11/18/2021 01:29:51'!
filtrarArchivosEnElDirectorio: unaColeccionDeArchivos

	^ unaColeccionDeArchivos select: [: unArchivo| listaDeFiltros allSatisfy:[: unFiltro| unFiltro puedeFiltrar: unArchivo] ].! !


!Filter methodsFor: 'testing subClass responsability' stamp: 'TC 11/18/2021 02:02:52'!
puedeFiltrar: unArchivo
	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Filter class' category: 'Grupo1-TP-Final'!
Filter class
	instanceVariableNames: ''!

!Filter class methodsFor: 'instance creation' stamp: 'TC 11/18/2021 00:53:26'!
filtrarPor: unaListaDeFiltros.
	
	^self new initializeFiltrarPor: unaListaDeFiltros. ! !


!classDefinition: #FilterCreationFile category: 'Grupo1-TP-Final'!
Filter subclass: #FilterCreationFile
	instanceVariableNames: 'fechaDeCreacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterCreationFile methodsFor: 'initialization' stamp: 'TC 11/18/2021 01:44:16'!
initializeConLaFecha: unaFechaDeCreacion 
	fechaDeCreacion := unaFechaDeCreacion.! !


!FilterCreationFile methodsFor: 'testing' stamp: 'TC 11/18/2021 01:45:02'!
puedeFiltrar: unArchivo
	^ (fechaDeCreacion = unArchivo fechaDeCreacion).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterCreationFile class' category: 'Grupo1-TP-Final'!
FilterCreationFile class
	instanceVariableNames: ''!

!FilterCreationFile class methodsFor: 'instance creation' stamp: 'TC 11/18/2021 01:43:19'!
conLaFecha: unaFechaDeCreacion
	^self new initializeConLaFecha: unaFechaDeCreacion. ! !


!classDefinition: #FilterText category: 'Grupo1-TP-Final'!
Filter subclass: #FilterText
	instanceVariableNames: 'texto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterText methodsFor: 'initialization' stamp: 'TC 11/18/2021 00:46:42'!
initializeConElTexto: unTexto 

	texto _ unTexto.! !


!FilterText methodsFor: 'accesing' stamp: 'TC 11/18/2021 01:04:22'!
filtrar: unaListaDeArchivos
	
	^ unaListaDeArchivos select: [:archivoEnLaLista | archivoEnLaLista contieneElTexto: texto].! !


!FilterText methodsFor: 'testing' stamp: 'TC 11/18/2021 01:30:58'!
puedeFiltrar: unArchivo 
	^ (unArchivo texto  = texto).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterText class' category: 'Grupo1-TP-Final'!
FilterText class
	instanceVariableNames: ''!

!FilterText class methodsFor: 'instance creation' stamp: 'TC 11/18/2021 00:45:39'!
conElTexto: unTexto 
	^self new initializeConElTexto: unTexto ! !


!classDefinition: #Folder category: 'Grupo1-TP-Final'!
Object subclass: #Folder
	instanceVariableNames: 'nombreCarpeta listaDeCarpetas listaDeArchivos fechaDeCreacion fechaDeModificacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Folder methodsFor: 'initialization' stamp: 'dk 11/15/2021 23:17:25'!
inicializarConNombre: unNombre
	nombreCarpeta _ unNombre.! !

!Folder methodsFor: 'initialization' stamp: 'TC 11/15/2021 23:49:58'!
initialize

	listaDeCarpetas _ Set new.
	listaDeArchivos _ Set new. 
	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.! !


!Folder methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:55:08'!
fechaDeCreacion
	^fechaDeCreacion! !

!Folder methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:55:22'!
fechaDeModificacion
	^fechaDeModificacion! !

!Folder methodsFor: 'accessing' stamp: 'dk 11/17/2021 17:53:55'!
listaDeArchivos

	^listaDeArchivos! !

!Folder methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:17:47'!
listaDeCarpetas
	^ listaDeCarpetas! !

!Folder methodsFor: 'accessing' stamp: 'TC 11/14/2021 21:52:04'!
nombre
	^ nombreCarpeta.! !


!Folder methodsFor: 'testing' stamp: 'dk 11/15/2021 23:17:52'!
nombreEsIgual: unNombre
	^ nombreCarpeta = unNombre.! !

!Folder methodsFor: 'testing' stamp: 'TC 11/14/2021 21:58:34'!
tieneArchivos
	^ listaDeArchivos notEmpty.! !

!Folder methodsFor: 'testing' stamp: 'TC 11/14/2021 21:58:10'!
tieneCarpetas
	^ listaDeCarpetas notEmpty.! !


!Folder methodsFor: 'public actions' stamp: 'TC 11/14/2021 22:21:13'!
agregarCarpeta: unaCarpeta 
	listaDeCarpetas add: unaCarpeta.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Folder class' category: 'Grupo1-TP-Final'!
Folder class
	instanceVariableNames: ''!

!Folder class methodsFor: 'instance creation' stamp: 'TC 11/14/2021 21:50:48'!
conNombre: unNombre
	^self new inicializarConNombre: unNombre.! !


!classDefinition: #Terminal category: 'Grupo1-TP-Final'!
Object subclass: #Terminal
	instanceVariableNames: 'listaDeUsuarios usuarioLogueado carpetaActual carpetaAnterior listaDeDirectoriosVistos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'initialization' stamp: 'dk 11/16/2021 23:27:29'!
initialize

	| defaultUserRoot |
	defaultUserRoot _ RootUser conNombre: 'root' yContraseña: 'root'.
	listaDeUsuarios _ Set new .
	listaDeUsuarios add: defaultUserRoot .	
	carpetaActual _ Folder conNombre: 'root' .
	
	listaDeDirectoriosVistos _ OrderedCollection new .
	listaDeDirectoriosVistos add: carpetaActual .! !

!Terminal methodsFor: 'initialization' stamp: 'dk 11/14/2021 20:26:56'!
initializeIniciarSesion: unUser 

	self iniciarSesion: unUser .
	
	! !


!Terminal methodsFor: 'testing' stamp: 'dk 11/15/2021 23:17:15'!
esDirectoRaiz

	^ listaDeDirectoriosVistos size = 1! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:57:33'!
estaElUsuarioLogueado: unUser 

	^ unUser esIgualElUserYContraseñaA: usuarioLogueado ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/15/2021 23:08:20'!
estaParadaEnElDirectorioRaiz

	^ self esDirectoRaiz .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:30:32'!
tieneAlUsuario: unUser 

	^ listaDeUsuarios includes: unUser .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:58:39'!
tieneAlUsuarioLogueado: unUsuario 
	^ (self tieneUnUsuarioLogueado) & (self estaElUsuarioLogueado: unUsuario) .! !

!Terminal methodsFor: 'testing' stamp: 'TC 11/14/2021 22:25:35'!
tieneCarpetasEnElDirectorioActual
	^ carpetaActual tieneCarpetas.! !

!Terminal methodsFor: 'testing' stamp: 'TC 11/16/2021 00:00:16'!
tieneElArchivoEnElDirectorioActual: unArchivo
	^ (carpetaActual listaDeArchivos) includes: unArchivo.! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/16/2021 23:52:10'!
tieneUnUsuarioLogueado

	^ usuarioLogueado notNil ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:33:35'!
unUsuarioTieneElMismoNombreQue: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | (unUserEnLaLista nombreEsIgual: unUser nombre)]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:34:13'!
unUsuarioTieneElMismoNombreYContraseñaQue: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | unUserEnLaLista esIgualElUserYContraseñaA: unUser]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/15/2021 23:14:14'!
unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista

	^ unaCarpetaEnLaLista nombreEsIgual: (unaCarpeta nombre)! !


!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:10:21'!
agregarCarpeta: unaCarpeta

	^ carpetaActual agregarCarpeta: unaCarpeta! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/14/2021 23:55:27'!
borrarUsuario: unUser 

	listaDeUsuarios remove: unUser 
		ifAbsent: [self errorUsuarioNoExistente]! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/16/2021 23:40:27'!
cd
	
	(self esDirectoRaiz ) 
		ifTrue: [
			self error: 'No se puede volver, estas parado en root'
		] ifFalse: [
			listaDeDirectoriosVistos removeLast .
			carpetaActual _ listaDeDirectoriosVistos last .	
		]
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:12:56'!
cd: unaCarpeta 
	
	| listaDeCarpetasEnElDirectorioActual carpetaSiguiente |
	listaDeCarpetasEnElDirectorioActual _ carpetaActual listaDeCarpetas.
	
	carpetaSiguiente _ listaDeCarpetasEnElDirectorioActual detect: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista] 
		ifNone: [self error: 'La carpeta no existe en este directorio'.] .


	listaDeDirectoriosVistos add: carpetaSiguiente .
	carpetaActual _ (listaDeDirectoriosVistos last) .! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/16/2021 00:10:17'!
errorArchivoExistente

	^ self error: 'No se puede crear un archivo con el mismo nombre'! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/18/2021 01:56:40'!
filtrarCon: coleccionDeFiltros
	^ (coleccionDeFiltros filtrarArchivosEnElDirectorio: carpetaActual listaDeArchivos). ! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:08:43'!
ingresarUsuario: unUserAIngresar
	
	(self unUsuarioTieneElMismoNombreQue: unUserAIngresar) 
		ifTrue: [self errorContraseñaOUsuarioIncorrecto] 
		ifFalse: [listaDeUsuarios add: unUserAIngresar].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/16/2021 23:33:30'!
iniciarSesion: unUserALoguease 
	
	(self unUsuarioTieneElMismoNombreYContraseñaQue: unUserALoguease) 
		ifTrue: [usuarioLogueado _ unUserALoguease] 
		ifFalse: [self errorContraseñaOUsuarioIncorrecto].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:13:17'!
mkdir: unaCarpeta

	|listaDeCarpetasEnElDirectorioActual|
	listaDeCarpetasEnElDirectorioActual _ carpetaActual listaDeCarpetas.
	
	(listaDeCarpetasEnElDirectorioActual anySatisfy: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista]) 
		ifTrue: [self errorLaCarpetaYaExiste] 
		ifFalse: [self agregarCarpeta: unaCarpeta].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:10:56'!
modificarUsuario: unUserAModificar por: unUserConModificaciones 

	(self unUsuarioTieneElMismoNombreQue: unUserAModificar) 
		ifTrue: [
			self ingresarUsuario: unUserConModificaciones .
			self borrarUsuario: unUserAModificar .
		] ifFalse: [
			self errorUsuarioNoExistente
		].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/17/2021 00:41:31'!
nano: unArchivo edicion: unTexto
	
	| listaDeArchivos |
	listaDeArchivos _ carpetaActual listaDeArchivos .
	
	(listaDeArchivos detect: [:unArchivoEnLaLista | (unArchivoEnLaLista nombreEsIgual: unArchivo nombre)] 
		ifNone: [ self error: 'El archivo que intenta modificar no existe']) 
		modificarTexto: unTexto! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/16/2021 00:42:25'!
rm: unArchivoABorrar
	|archivoABorrar listaDeArchivos|
	listaDeArchivos _ carpetaActual listaDeArchivos.
	
	archivoABorrar _ listaDeArchivos detect:[: unArchivo| unArchivo nombreEsIgual: unArchivoABorrar nombre] 
	ifNone:[self error: 'El archivo a borrar no existe'].
	carpetaActual listaDeArchivos remove: archivoABorrar.
	! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/16/2021 00:10:24'!
touch: unArchivo
	|listaDeArchivosEnElDirectorioActual|
	listaDeArchivosEnElDirectorioActual _ carpetaActual listaDeArchivos.
	(listaDeArchivosEnElDirectorioActual anySatisfy: [:unArchivoEnLaLista| unArchivoEnLaLista nombreEsIgual: unArchivo nombre]) 
	ifTrue:[self errorArchivoExistente]
	ifFalse:[listaDeArchivosEnElDirectorioActual add: unArchivo.]
	
	! !


!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:13:48'!
carpetaActual
	
	^ carpetaActual! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/17/2021 00:34:08'!
cat: unArchivo 

	| listaDeArchivos |
	listaDeArchivos _ carpetaActual listaDeArchivos .
	
	^ (listaDeArchivos detect: [:unArchivoEnLaLista | (unArchivoEnLaLista nombreEsIgual: unArchivo nombre)] 
		ifNone: [ self error: 'El archivo que intenta leer no existe']) texto! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:06:59'!
errorContraseñaOUsuarioIncorrecto

	^ self error: 'El nombre y/o contraseña es incorrecta'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:10:07'!
errorLaCarpetaYaExiste

	^ self error: 'La carpeta ya existe en este directorio'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:15:42'!
errorUsuarioNoExistente

	^ self error: 'El usuario no existe'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/17/2021 00:51:47'!
filtrarArchivosQueContengan: unTexto 
	
	| listaDeArchivos |
	listaDeArchivos _ carpetaActual listaDeArchivos .
	
	^ listaDeArchivos select: [:archivoEnLaLista | archivoEnLaLista contieneElTexto: unTexto]
	! !

!Terminal methodsFor: 'accessing' stamp: 'TC 11/16/2021 00:21:31'!
ls
	|listaDeArchivosYCarpetas|
	listaDeArchivosYCarpetas _ Set new.
	listaDeArchivosYCarpetas addAll: carpetaActual listaDeArchivos.
	listaDeArchivosYCarpetas addAll: carpetaActual listaDeCarpetas.
	^ listaDeArchivosYCarpetas.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Terminal class' category: 'Grupo1-TP-Final'!
Terminal class
	instanceVariableNames: ''!

!Terminal class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 23:32:13'!
iniciarSesion: unUser
	^self new initializeIniciarSesion: unUser ! !


!classDefinition: #User category: 'Grupo1-TP-Final'!
Object subclass: #User
	instanceVariableNames: 'nombre contraseña'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!User methodsFor: 'accessing' stamp: 'dk 11/14/2021 20:37:31'!
contraseña

	^ contraseña! !

!User methodsFor: 'accessing' stamp: 'dk 11/14/2021 20:37:35'!
nombre

	^ nombre! !


!User methodsFor: 'testing' stamp: 'dk 11/14/2021 20:37:40'!
contraseñaEsIgual: unaContraseña 

	^ contraseña = unaContraseña ! !

!User methodsFor: 'testing' stamp: 'dk 11/16/2021 23:29:10'!
esIgualElUserYContraseñaA: unUser 

	^ (self nombreEsIgual: unUser nombre) & (self contraseñaEsIgual: unUser contraseña)! !

!User methodsFor: 'testing' stamp: 'dk 11/14/2021 20:37:46'!
nombreEsIgual: unNombre 

	^ nombre = unNombre ! !


!classDefinition: #PublicUser category: 'Grupo1-TP-Final'!
User subclass: #PublicUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PublicUser methodsFor: 'initialization' stamp: 'dk 11/12/2021 23:48:10'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre := unNombre.
	contraseña := unaContraseña.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublicUser class' category: 'Grupo1-TP-Final'!
PublicUser class
	instanceVariableNames: ''!

!PublicUser class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 23:48:18'!
conNombre: unNombre yContraseña: unaContraseña
	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !


!classDefinition: #RootUser category: 'Grupo1-TP-Final'!
User subclass: #RootUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!RootUser methodsFor: 'initialization' stamp: 'dk 11/14/2021 20:37:55'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre := unNombre.
	contraseña := unaContraseña.! !


!RootUser methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:38:19'!
borrarUsuario: unUser en: unaTerminal

	unaTerminal borrarUsuario: unUser .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:38:06'!
modificarUsuario: unUsuario por: unUsuarioConModificaciones en: unaTerminal
 
	unaTerminal modificarUsuario: unUsuario por: unUsuarioConModificaciones .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:38:10'!
registrarUsuario: unUser en: unaTerminal

	unaTerminal ingresarUsuario: unUser .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootUser class' category: 'Grupo1-TP-Final'!
RootUser class
	instanceVariableNames: ''!

!RootUser class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 00:45:03'!
conNombre: unNombre yContraseña: unaContraseña 
	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !
