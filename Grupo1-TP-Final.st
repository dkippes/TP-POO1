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
	instanceVariableNames: 'unUserRootDefault unUserRootDiego1234 unUserRootDiego4321 unUserPublicDiego4321 carpetaTomas carpetaDiego archivoDeTexto archivoDeTexto2 filtroDeTexto filtroDeFecha filtroCompuestoPorTexto filtroCompuestoPorTextoYFecha filtroCompuestoPorFecha'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 21:01:26'!
errorContraseñaOUsuarioIncorrecto

	^ 'El nombre y/o contraseña es incorrecta'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 21:01:19'!
errorUsuarioNoExistente

	^ 'El usuario no existe'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'TC 11/19/2021 00:45:39'!
unaTerminalConUnUsuarioPublicoLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	^ unaTerminal .! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 20:45:57'!
unaTerminalConUnUsuarioRootDefaultLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	^ unaTerminal .! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/19/2021 00:25:24'!
unaTerminalRootConArchivos

	| unaTerminal unArchivoDeTexto unArchivoDeTexto2 |
	
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoDeTexto _ archivoDeTexto .
	unArchivoDeTexto2 _ archivoDeTexto2 .
	
	"Exercise"
	unaTerminal touch: unArchivoDeTexto .
	unaTerminal touch: unArchivoDeTexto2 .
	unaTerminal nano: unArchivoDeTexto2 edicion: 'Texto Modificado'.
	
	^ unaTerminal ! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/19/2021 00:27:23'!
unaTerminalRootConArchivosYCarpetas

	| unaTerminal |
	
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto2 .
	unaTerminal nano: archivoDeTexto2 edicion: 'Texto Modificado'.
	unaTerminal mkdir: 	carpetaTomas .
	
	^ unaTerminal ! !


!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:02:33'!
errorNoSePuedeRetrocederDesdeRoot

	^ 'No se puede volver, estas parado en root'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/18/2021 23:54:54'!
errorPorArchivoInexistente

	^ 'El archivo que intenta leer no existe'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/18/2021 23:56:27'!
errorPorArchivoInexistenteAlQuererSerModificado

	^ 'El archivo que intenta modificar no existe'! !

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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 00:29:11'!
test017_cuandoUnUsuarioIngresaAUnaCarpetas_esteLuegoRegresaARoot

	| unaTerminal unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ carpetaTomas .

	"Exersice"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
	unaTerminal cd .
	
	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 00:28:05'!
test018_cuandoUnUsuarioIngresaAVariasCarpetas_esteSePosicionaEnRoot

	| unaTerminal unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ carpetaTomas .

	"Exersice"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 00:27:02'!
test021_cuandoUnUsuarioListaElContenidoDelDirectorio_conElComandoLS_esteListaTodosLosArchivosYLasCarpetas

	| unaTerminal listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivosYCarpetas .
	listaDeArchivosYCarpetas _ Set new.
	listaDeArchivosYCarpetas add: archivoDeTexto2 .
	listaDeArchivosYCarpetas add: carpetaTomas .
	
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/18/2021 23:54:54'!
test025_cuandoUnUsuarioRootLeaUnArchivoDeText_esteNoExisteEnElDirectorioActual

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cat: archivoDeTexto]
        signal: Error
        withDescription: self errorPorArchivoInexistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/18/2021 23:55:47'!
test026_cuandoUnUsuarioRootModifiqueUnArchivoDeTexto_esteReemplazaElTextoExistente

	| unaTerminal unaArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ archivoDeTexto .
	unaTerminal touch: unaArchivoNuevo .
	
	"Exercise"
	unaTerminal nano: unaArchivoNuevo edicion: 'Texto Modificado'.
	

	"Assert"
	Assert that: (unaTerminal cat: unaArchivoNuevo) isEqualTo: 'Texto Modificado'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 00:22:26'!
test027_cuandoUnUsuarioRootModifiqueUnArchivoDeTexto_esteNoExiste

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Assert"
	Assert
        should: [unaTerminal nano: archivoDeTexto edicion: 'Texto Modificado']
        signal: Error
        withDescription: self errorPorArchivoInexistenteAlQuererSerModificado .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 00:25:24'!
test028_cuandoUnUsuarioFiltreUnArchivoPorTextoDado_esteMuestra1ArchivosEncontrado

	| unaTerminal listaDeArchivosEncontrados unFiltro |
	
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto2 .
	unFiltro _ filtroCompuestoPorTexto .
	
	"Excercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .
	! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 00:25:24'!
test029_cuandoUnUsuarioFiltreUnArchivoPorTextoDado_esteNoEncuentraResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeTexto |
	
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	unFiltroDeTexto _ FilterText conElTexto: 'Texto no encontrado' .
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDeTexto } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 00:25:24'!
test030_cuandoUnUsuarioFiltreUnArchivoPorUnaFechaDeCreacionDada_estaDevuelveUnaColeccionDeArchivos

	| unaTerminal listaDeArchivosEncontrados unFiltro|
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto .
	listaDeArchivosEncontrados add: archivoDeTexto2 .
	unFiltro _ filtroCompuestoPorFecha .
	
	"Excercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:30:39'!
test031_cuandoUnUsuarioCreaUnArchivo_EsteLePertenece 
	
	"Setup"
	|unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
		
	"Assert"
	Assert that: archivoDeTexto creadoPorUsuario isEqualTo: unUserRootDefault .
	Assert isTrue:(archivoDeTexto fueCreadoPor: unUserRootDefault ).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:34:25'!
test032_cuandoUnUsuarioCreaUnArchivo_EsteNoLePertenece 
	
	"Setup"
	|unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unaTerminal ingresarUsuario: 	unUserRootDiego1234 .
	unaTerminal iniciarSesion: unUserRootDiego1234 .
	unaTerminal touch: archivoDeTexto.
		
	"Assert"
	Assert isFalse:(archivoDeTexto fueCreadoPor: unUserRootDefault).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/19/2021 01:01:23'!
test033_cuandoUnUsuarioFiltreUnArchivoPorUnUsuarioDado_esteEncuentraResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeUsuario |
	
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto.
	listaDeArchivosEncontrados add: archivoDeTexto2.
	unFiltroDeUsuario _ FilterUser conElUsuario: unUserRootDefault.
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDeUsuario } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/19/2021 01:05:00'!
test034_cuandoUnUsuarioFiltreUnArchivoPorUnUsuarioDado_esteEncuentraNoResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeUsuario |
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	unFiltroDeUsuario _ FilterUser conElUsuario: unUserRootDiego4321.
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDeUsuario } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 21:36:52'!
test035_cuandoUnUsuarioLeeUnArchivoDeTexto_EsteNoTienePermisosDeLecturaParaLeerElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321.

	"Assert"
	Assert
        should: [unaTerminal cat: archivoDeTexto]
        signal: Error
        withDescription: 'El usuario no tiene permisos de lectura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 22:43:54'!
test036_cuandoUnUsuarioRootLeeUnArchivoDeTexto_EsteTienePermisosDeLectura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.

	"Assert"
	Assert that: (unaTerminal cat: archivoDeTexto) isEqualTo: '' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:35:46'!
test037_cuandoUnUsuarioPropietarioLeeUnArchivoDeTexto_esteTienePermisosDeLectura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserRootDiego1234 .
	unaTerminal iniciarSesion: unUserRootDiego1234 .
	unaTerminal touch: archivoDeTexto.

	"Assert"
	Assert that: (unaTerminal cat: archivoDeTexto) isEqualTo: '' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 22:46:35'!
test038_cuandoUnUsuarioEscribeUnArchivoDeTexto_esteNoTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	"Assert"
	Assert
        should: [unaTerminal nano: archivoDeTexto edicion: 'Texto Test']
        signal: Error
        withDescription: 'El usuario no tiene permisos de escritura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 22:53:28'!
test039_cuandoUnUsuarioRootEscribeUnArchivoDeTexto_esteTienePermisosDeEscritura

	|unaTerminal unArchivoAModificar |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoAModificar _ archivoDeTexto .
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal nano: unArchivoAModificar edicion: 'Texto Modificado' .
	
	"Assert"
	Assert that: (unaTerminal cat: unArchivoAModificar) isEqualTo: 'Texto Modificado'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:36:46'!
test040_cuandoUnUsuarioPropietarioEscribeUnArchivoDeTexto_esteTienePermisosDeEscritura

	|unaTerminal unArchivoAModificar |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoAModificar _ archivoDeTexto .
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserRootDiego1234 .
	unaTerminal iniciarSesion: unUserRootDiego1234 .
	unaTerminal touch: archivoDeTexto.
	unaTerminal nano: unArchivoAModificar edicion: 'Texto Modificado' .
	
	"Assert"
	Assert that: (unaTerminal cat: unArchivoAModificar) isEqualTo: 'Texto Modificado'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:02:09'!
test041_cuandoUnUsuarioEjecuteUnArchivoDeTexto_esteNoTienePermisosDeEjecucion

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	"Assert"
	Assert
        should: [unaTerminal ejecutar: archivoDeTexto]
        signal: Error
        withDescription: 'El usuario no tiene permisos de ejecucion'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:07:08'!
test042_cuandoUnUsuarioRootEjecuteUnArchivoDeTexto_esteTienePermisosDeEjecucion

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ejecutar: archivoDeTexto) isEqualTo: archivoDeTexto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:36:11'!
test043_cuandoUnUsuarioPropietarioEjecuteUnArchivoDeTexto_esteTienePermisosDeEjecucion

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserRootDiego1234 .
	unaTerminal iniciarSesion: unUserRootDiego1234 .
	unaTerminal touch: archivoDeTexto.
	
	"Assert"
	Assert that: (unaTerminal ejecutar: archivoDeTexto) isEqualTo: archivoDeTexto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:10:43'!
test044_cuandoUnUsuarioRemuevaUnArchivoDeTexto_esteNoTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	"Assert"
	Assert
        should: [unaTerminal rm: archivoDeTexto]
        signal: Error
        withDescription: 'El usuario no tiene permisos de escritura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:10:32'!
test045_cuandoUnUsuarioRootRemuevaUnArchivoDeTexto_esteTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal rm: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: Set new .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:36:24'!
test046_cuandoUnUsuarioPropietarioRemuevaUnArchivoDeTexto_esteTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserRootDiego1234 .
	unaTerminal iniciarSesion: unUserRootDiego1234 .
	unaTerminal touch: archivoDeTexto.
	unaTerminal rm: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: Set new .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:16:41'!
test047_cuandoUnUsuarioCreaUnaCarpeta_esteNoTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal mkdir: carpetaTomas .
	unaTerminal ingresarUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	"Assert"
	Assert
        should: [unaTerminal mkdir: carpetaDiego]
        signal: Error
        withDescription: 'El usuario no tiene permisos de escritura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/19/2021 23:27:47'!
test048_cuandoUnUsuarioCreaUnaArchivoDeTexto_esteNoTienePermisosDeEscrituraSobreLaCarpeta

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	"Assert"
	Assert
        should: [unaTerminal touch: archivoDeTexto .]
        signal: Error
        withDescription: 'El usuario no tiene permisos de escritura'.! !


!TerminalTest methodsFor: 'setUp/tearDown' stamp: 'dk 11/19/2021 00:20:18'!
setUp

	unUserRootDefault _ RootUser conNombre: 'root' yContraseña: 'root' .
	unUserRootDiego1234 _ RootUser conNombre: 'Diego' yContraseña: '1234' .
	unUserRootDiego4321 _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	unUserPublicDiego4321 _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	
	carpetaTomas _ Folder	 conNombre: 'Tomas' .
	carpetaDiego _ Folder	 conNombre: 'Diego' .
	
	archivoDeTexto _ File conNombre: 'Archivo1.txt' .
	archivoDeTexto2 _ File conNombre: 'Archivo2.txt' .
	
	filtroDeTexto _ FilterText conElTexto: 'Texto Modificado' .
	filtroDeFecha _ FilterCreationFile conLaFecha: FixedGregorianDate today .
	
	filtroCompuestoPorTexto _ FiltroCompuesto filtrarPor: { filtroDeTexto } .
	filtroCompuestoPorFecha _ FiltroCompuesto filtrarPor: { filtroDeFecha } .
	filtroCompuestoPorTextoYFecha _ FiltroCompuesto filtrarPor: { filtroDeTexto . filtroDeFecha } .! !


!classDefinition: #File category: 'Grupo1-TP-Final'!
Object subclass: #File
	instanceVariableNames: 'nombre fechaDeCreacion fechaDeModificacion texto creadoPorUsuario permisosDeLectura permisosDeEscritura permisosDeEjecucion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!File methodsFor: 'initialization' stamp: 'dk 11/19/2021 21:20:59'!
initialize

	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.

	texto _ '' .
	permisosDeLectura _ PermisoDeLectura new.
	permisosDeEscritura _ PermisoDeEscritura new.
	permisosDeEjecucion _ PermisoDeEjecucion new.! !

!File methodsFor: 'initialization' stamp: 'TC 11/15/2021 23:41:17'!
initializeConNombre: unNombre 
	nombre := unNombre.! !


!File methodsFor: 'accessing' stamp: 'TC 11/19/2021 00:46:30'!
creadoPorUsuario
	^ creadoPorUsuario.! !

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

!File methodsFor: 'testing' stamp: 'TC 11/19/2021 00:56:05'!
fueCreadoPor: unUsuario 
	^ (creadoPorUsuario nombre = unUsuario nombre).! !

!File methodsFor: 'testing' stamp: 'TC 11/16/2021 00:11:19'!
nombreEsIgual: nombreArchivo
	^ (nombre = nombreArchivo) ! !

!File methodsFor: 'testing' stamp: 'dk 11/19/2021 23:02:50'!
tienePermisosDeEjecucionDelUsuario: unUsuario 
	^ (permisosDeEjecucion puedeEjecutar: unUsuario)! !

!File methodsFor: 'testing' stamp: 'dk 11/19/2021 22:49:42'!
tienePermisosDeEscrituraDelUsuario: unUsuario 
	^ (permisosDeEscritura puedeEscribir: unUsuario)! !


!File methodsFor: 'public actions' stamp: 'TC 11/19/2021 00:52:21'!
creadoPor: unUsuario
	creadoPorUsuario _ unUsuario.! !

!File methodsFor: 'public actions' stamp: 'dk 11/17/2021 00:39:11'!
modificarTexto: unTexto 
	texto _ unTexto .! !

!File methodsFor: 'public actions' stamp: 'dk 11/19/2021 21:26:03'!
tienePermisosDeLecturaDelUsuario: unUsuario

	^(permisosDeLectura puedeLeer: unUsuario)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'File class' category: 'Grupo1-TP-Final'!
File class
	instanceVariableNames: ''!

!File class methodsFor: 'instance creation' stamp: 'TC 11/15/2021 23:40:45'!
conNombre: unNombre
	
	^self new initializeConNombre: unNombre. ! !


!classDefinition: #Filter category: 'Grupo1-TP-Final'!
Object subclass: #Filter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!


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


!classDefinition: #FiltroCompuesto category: 'Grupo1-TP-Final'!
Filter subclass: #FiltroCompuesto
	instanceVariableNames: 'listaDeFiltros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FiltroCompuesto methodsFor: 'as yet unclassified' stamp: 'dk 11/18/2021 18:01:44'!
filtrarArchivosEnElDirectorio: unaColeccionDeArchivos

	^ unaColeccionDeArchivos select: [: unArchivo| listaDeFiltros allSatisfy:[: unFiltro| unFiltro puedeFiltrar: unArchivo] ].! !

!FiltroCompuesto methodsFor: 'as yet unclassified' stamp: 'dk 11/18/2021 18:01:09'!
initializeFiltrarPor: unaListaDeFiltros 
	listaDeFiltros _ unaListaDeFiltros.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FiltroCompuesto class' category: 'Grupo1-TP-Final'!
FiltroCompuesto class
	instanceVariableNames: ''!

!FiltroCompuesto class methodsFor: 'instance creation' stamp: 'dk 11/18/2021 17:47:43'!
filtrarPor: unaListaDeFiltros.
	
	^self new initializeFiltrarPor: unaListaDeFiltros. ! !


!classDefinition: #FilterUser category: 'Grupo1-TP-Final'!
Object subclass: #FilterUser
	instanceVariableNames: 'usuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterUser methodsFor: 'initialization' stamp: 'TC 11/19/2021 01:02:29'!
initializeConElUsuario: unUsuario 
	usuario := unUsuario.! !


!FilterUser methodsFor: 'testing' stamp: 'TC 11/19/2021 01:03:52'!
puedeFiltrar: unArchivo
	^ unArchivo creadoPorUsuario nombre = usuario nombre.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterUser class' category: 'Grupo1-TP-Final'!
FilterUser class
	instanceVariableNames: ''!

!FilterUser class methodsFor: 'instance creation' stamp: 'TC 11/19/2021 01:01:54'!
conElUsuario: unUsuario
	^self new initializeConElUsuario: unUsuario. ! !


!classDefinition: #Folder category: 'Grupo1-TP-Final'!
Object subclass: #Folder
	instanceVariableNames: 'nombreCarpeta listaDeCarpetas listaDeArchivos fechaDeCreacion fechaDeModificacion permisosDeLectura permisosDeEscritura permisosDeEjecucion creadoPorUsuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Folder methodsFor: 'initialization' stamp: 'dk 11/15/2021 23:17:25'!
inicializarConNombre: unNombre
	nombreCarpeta _ unNombre.! !

!Folder methodsFor: 'initialization' stamp: 'dk 11/19/2021 23:20:00'!
initialize

	listaDeCarpetas _ Set new.
	listaDeArchivos _ Set new. 
	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.
	
	permisosDeLectura _ PermisoDeLectura new.
	permisosDeEscritura _ PermisoDeEscritura new.
	permisosDeEjecucion _ PermisoDeEjecucion new.! !


!Folder methodsFor: 'accessing' stamp: 'dk 11/19/2021 23:22:29'!
creadoPorUsuario
	^ creadoPorUsuario! !

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

!Folder methodsFor: 'testing' stamp: 'dk 11/19/2021 23:21:53'!
tienePermisosDeEscrituraDelUsuario: unUsuario 
	^ (permisosDeEscritura puedeEscribir: unUsuario)! !


!Folder methodsFor: 'public actions' stamp: 'TC 11/14/2021 22:21:13'!
agregarCarpeta: unaCarpeta 
	listaDeCarpetas add: unaCarpeta.! !

!Folder methodsFor: 'public actions' stamp: 'dk 11/19/2021 23:24:33'!
creadoPor: unUsuario

	creadoPorUsuario _ unUsuario! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Folder class' category: 'Grupo1-TP-Final'!
Folder class
	instanceVariableNames: ''!

!Folder class methodsFor: 'instance creation' stamp: 'TC 11/14/2021 21:50:48'!
conNombre: unNombre
	^self new inicializarConNombre: unNombre.! !


!classDefinition: #PermisoDeEjecucion category: 'Grupo1-TP-Final'!
Object subclass: #PermisoDeEjecucion
	instanceVariableNames: 'listaDeUsuariosQuePuedenEjecutar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PermisoDeEjecucion methodsFor: 'testing' stamp: 'dk 11/19/2021 23:03:23'!
puedeEjecutar: unUsuario 
	^ listaDeUsuariosQuePuedenEjecutar anySatisfy: [:unUsuarioEnLaLista | unUsuario nombreEsIgual: unUsuarioEnLaLista]! !


!PermisoDeEjecucion methodsFor: 'initialization' stamp: 'dk 11/19/2021 23:03:44'!
initialize

	listaDeUsuariosQuePuedenEjecutar _ Set new .! !


!classDefinition: #PermisoDeEscritura category: 'Grupo1-TP-Final'!
Object subclass: #PermisoDeEscritura
	instanceVariableNames: 'listaDeUsuariosQuePuedenEscribir'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PermisoDeEscritura methodsFor: 'testing' stamp: 'dk 11/19/2021 22:50:35'!
puedeEscribir: unUsuario 
	^ listaDeUsuariosQuePuedenEscribir anySatisfy: [:unUsuarioEnLaLista | unUsuario nombreEsIgual: unUsuarioEnLaLista]! !


!PermisoDeEscritura methodsFor: 'initialization' stamp: 'dk 11/19/2021 22:50:59'!
initialize

	listaDeUsuariosQuePuedenEscribir _ Set new ! !


!classDefinition: #PermisoDeLectura category: 'Grupo1-TP-Final'!
Object subclass: #PermisoDeLectura
	instanceVariableNames: 'listaDeUsuariosQuePuedenLeer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PermisoDeLectura methodsFor: 'testing' stamp: 'dk 11/19/2021 21:23:55'!
initialize

	listaDeUsuariosQuePuedenLeer _ Set new .! !

!PermisoDeLectura methodsFor: 'testing' stamp: 'dk 11/19/2021 21:23:22'!
puedeLeer: unUser 
	^ listaDeUsuariosQuePuedenLeer anySatisfy: [:unUsuarioEnLaLista | unUser nombreEsIgual: unUsuarioEnLaLista]! !


!classDefinition: #Terminal category: 'Grupo1-TP-Final'!
Object subclass: #Terminal
	instanceVariableNames: 'listaDeUsuarios usuarioLogueado carpetaActual carpetaAnterior listaDeDirectoriosVistos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'initialization' stamp: 'dk 11/19/2021 23:26:40'!
initialize

	| defaultUserRoot |
	defaultUserRoot _ RootUser conNombre: 'root' yContraseña: 'root'.
	listaDeUsuarios _ Set new .
	listaDeUsuarios add: defaultUserRoot .	
	carpetaActual _ Folder conNombre: 'root' .
	carpetaActual creadoPor: defaultUserRoot .
	
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

!Terminal methodsFor: 'public actions' stamp: 'dk 11/19/2021 23:06:05'!
ejecutar: unArchivo 
	"Ejecucion en nuestro dominion no hace nada. Solo se fija si existe y el usuario tiene permisos de ejecucion"
	| listaDeArchivos  archivo|
	listaDeArchivos _ carpetaActual listaDeArchivos .
	
	archivo _ (listaDeArchivos detect: [:unArchivoEnLaLista | (unArchivoEnLaLista nombreEsIgual: unArchivo nombre)] 
		ifNone: [ self error: 'El archivo que intenta ejecutar no existe']) .
		
	( (archivo tienePermisosDeEjecucionDelUsuario: usuarioLogueado) 
		| (unArchivo creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre)) 
		| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de ejecucion'].
		
	^ archivo .! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/16/2021 00:10:17'!
errorArchivoExistente

	^ self error: 'No se puede crear un archivo con el mismo nombre'! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/18/2021 17:38:53'!
filtrarCon: filtro
	^ (filtro filtrarArchivosEnElDirectorio: carpetaActual listaDeArchivos). ! !

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

!Terminal methodsFor: 'public actions' stamp: 'dk 11/19/2021 23:24:11'!
mkdir: unaCarpeta

	|listaDeCarpetasEnElDirectorioActual|
	listaDeCarpetasEnElDirectorioActual _ carpetaActual listaDeCarpetas.
	
	(listaDeCarpetasEnElDirectorioActual anySatisfy: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista]) 
		ifTrue: [self errorLaCarpetaYaExiste] .
		
	( (carpetaActual tienePermisosDeEscrituraDelUsuario: usuarioLogueado) 
		| (carpetaActual creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre)) 
		| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
	
	unaCarpeta creadoPor: usuarioLogueado .
	self agregarCarpeta: unaCarpeta! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:10:56'!
modificarUsuario: unUserAModificar por: unUserConModificaciones 

	(self unUsuarioTieneElMismoNombreQue: unUserAModificar) 
		ifTrue: [
			self ingresarUsuario: unUserConModificaciones .
			self borrarUsuario: unUserAModificar .
		] ifFalse: [
			self errorUsuarioNoExistente
		].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/19/2021 22:48:44'!
nano: unArchivo edicion: unTexto
	
	| listaDeArchivos archivoAModificar |
	listaDeArchivos _ carpetaActual listaDeArchivos .
	
	archivoAModificar _ (listaDeArchivos detect: [:unArchivoEnLaLista | (unArchivoEnLaLista nombreEsIgual: unArchivo nombre)] 
		ifNone: [ self error: 'El archivo que intenta modificar no existe']) .
		
		
	( (archivoAModificar tienePermisosDeEscrituraDelUsuario: usuarioLogueado) 
		| (archivoAModificar creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre)) 
		| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
		
	archivoAModificar modificarTexto: unTexto .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/19/2021 23:09:30'!
rm: unArchivoABorrar

	|archivoABorrar listaDeArchivos|
	listaDeArchivos _ carpetaActual listaDeArchivos.
	
	archivoABorrar _ listaDeArchivos detect:[: unArchivo| unArchivo nombreEsIgual: unArchivoABorrar nombre] 
	ifNone:[self error: 'El archivo a borrar no existe'].
	
	( (archivoABorrar tienePermisosDeEscrituraDelUsuario: usuarioLogueado) 
		| (archivoABorrar creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre)) 
		| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
	
	carpetaActual listaDeArchivos remove: archivoABorrar.
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/19/2021 23:28:59'!
touch: unArchivo

	|listaDeArchivosEnElDirectorioActual|
	listaDeArchivosEnElDirectorioActual _ carpetaActual listaDeArchivos.
	
	(listaDeArchivosEnElDirectorioActual anySatisfy: [:unArchivoEnLaLista| unArchivoEnLaLista nombreEsIgual: unArchivo nombre]) 
		ifTrue:[self errorArchivoExistente] .
	
	( (carpetaActual tienePermisosDeEscrituraDelUsuario: usuarioLogueado) 
		| (carpetaActual creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre)) 
		| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
	
	unArchivo creadoPor: usuarioLogueado.  
	listaDeArchivosEnElDirectorioActual add: unArchivo.! !


!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:13:48'!
carpetaActual
	
	^ carpetaActual! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/19/2021 22:37:50'!
cat: unArchivo 
	
	| listaDeArchivos  archivo|
	listaDeArchivos _ carpetaActual listaDeArchivos .
	archivo _ (listaDeArchivos detect: [:unArchivoEnLaLista | (unArchivoEnLaLista nombreEsIgual: unArchivo nombre)] 
		ifNone: [ self error: 'El archivo que intenta leer no existe']) .
	
	( (archivo tienePermisosDeLecturaDelUsuario: usuarioLogueado) 
		| (unArchivo creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre)) 
		| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de lectura'].
		
	^ archivo texto.	 ! !

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
