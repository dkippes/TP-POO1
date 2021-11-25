!classDefinition: #SistemaDeArchivosTest category: 'Grupo1-TP-Final'!
TestCase subclass: #SistemaDeArchivosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!SistemaDeArchivosTest methodsFor: 'sistemaDeArchivos_testing' stamp: 'dk 11/25/2021 01:26:30'!
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

!SistemaDeArchivosTest methodsFor: 'sistemaDeArchivos_testing' stamp: 'dk 11/25/2021 01:26:40'!
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
	instanceVariableNames: 'unUserRootDefault unUserRootDiego1234 unUserRootDiego4321 unUserPublicDiego4321 carpetaTomas carpetaDiego archivoDeTexto archivoDeTexto2 filtroDeTexto filtroDeFecha filtroCompuestoPorTexto filtroCompuestoPorTextoYFecha filtroCompuestoPorFecha unUserPublicTomas4321'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/25/2021 01:40:16'!
errorContraseñaOUsuarioIncorrecto

	^ 'El nombre y/o contraseña es incorrecta'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/25/2021 01:40:20'!
errorUsuarioNoExistente

	^ 'El usuario no existe'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/25/2021 01:40:26'!
unaTerminalConUnUsuarioPublicoLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	^ unaTerminal .! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/25/2021 01:40:30'!
unaTerminalConUnUsuarioRootDefaultLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	^ unaTerminal .! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/25/2021 01:40:44'!
unaTerminalRootConArchivos

	| unaTerminal unArchivoDeTexto unArchivoDeTexto2 |
	
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoDeTexto _ archivoDeTexto .
	unArchivoDeTexto2 _ archivoDeTexto2 .
	
	unaTerminal touch: unArchivoDeTexto .
	unaTerminal touch: unArchivoDeTexto2 .
	unaTerminal nano: unArchivoDeTexto2 edicion: 'Texto Modificado'.
	
	^ unaTerminal ! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/25/2021 01:40:54'!
unaTerminalRootConArchivosYCarpetas

	| unaTerminal |
	
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	unaTerminal touch: archivoDeTexto2 .
	unaTerminal nano: archivoDeTexto2 edicion: 'Texto Modificado'.
	unaTerminal mkdir: 	carpetaTomas .
	
	^ unaTerminal ! !


!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:02:33'!
errorNoSePuedeRetrocederDesdeRoot

	^ 'No se puede volver, estas parado en root'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/20/2021 18:48:21'!
errorPorArchivoInexistente

	^ 'El archivo no existe'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/16/2021 23:59:36'!
errorPorCarpetaInexistente

	^ 'La carpeta no existe en este directorio'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/17/2021 00:07:07'!
errorPorCrearUnArchivoConElMismoNombreEnElDirectorio

	^ 'No se puede crear un archivo con el mismo nombre'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:41:22'!
test001_cuandoUnaTerminalSeCrea_iniciaSesionUnUsuarioRoot

	"Setup"
	| terminal unUsuarioRoot |
	unUsuarioRoot _ RootUser conNombre: 'root' yContraseña: 'root' .
	terminal _ Terminal iniciarSesion: unUsuarioRoot .
	
	Assert isTrue: (terminal tieneAlUsuarioLogueado: unUsuarioRoot) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:41:28'!
test002_cuandoUnaTerminalSeCrea_unUsuarioRoot_registraUnUsuario_esteIniciaSesion

	"Setup"
	| unUsuarioLogueado unaTerminal |
	unUsuarioLogueado _ PublicUser conNombre: 'Diego' yContraseña: '1234' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioLogueado en: unaTerminal .
	unaTerminal iniciarSesion: unUsuarioLogueado .
	
	Assert isTrue: (unaTerminal tieneAlUsuarioLogueado: unUsuarioLogueado) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:41:35'!
test003_cuandoUnaTerminalSeCrea_unUsuarioTrataDeLoguearseInsactifactoriamente

	"Setup & Exercise"
	| unUserInexistente |
	unUserInexistente _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserInexistente]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:41:41'!
test004_cuandoUnaTerminalSeCrea_unUsuarioRootTrataDeLoguearseInsactifactoriamente

	"Setup"
	| unUserRootInexistente |
	unUserRootInexistente _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserRootInexistente ]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:41:46'!
test005_cuandoUnaTerminalSeCrea_unUsuarioRoot_registraUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isTrue: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:41:52'!
test006_cuandoUnaTerminalSeCrea_unUsuarioRoot_borraUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	unUserRootDefault borrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isFalse: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:41:59'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:04'!
test008_cuandoUnaTerminalSeCrea_unUsuarioRoot_trataDeBorraUnUsuarioInexistente

	"Setup"
	| terminal |
	terminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	Assert
        should: [ unUserRootDefault borrarUsuario: unUserPublicDiego4321 en: terminal  ]
        signal: Error
        withDescription: self errorUsuarioNoExistente .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:12'!
test009_cuandoUnaTerminalSeCrea_unUsuarioRoot_modificaUnUsuario

	"Setup"
	| unaTerminal unUsuarioModificado unUsuarioNuevo |
	unUsuarioNuevo _ unUserPublicDiego4321 .
	unUsuarioModificado _ PublicUser conNombre: 'Tomas' yContraseña: '9876' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioNuevo en: unaTerminal .
	unUserRootDefault modificarUsuario: unUsuarioNuevo por: unUsuarioModificado en: unaTerminal .
	
	Assert isTrue: (unaTerminal tieneAlUsuario: unUsuarioNuevo) .
	Assert that: unUsuarioNuevo nombre isEqualTo: 'Tomas' .
	Assert that: unUsuarioNuevo contraseña isEqualTo: '9876' .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:25'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:29'!
test011_cuandoUnUsuarioIniciaSesion_esteEstaParadoEnLaCarpetaRoot

	"Setup"
	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
		
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:36'!
test012_cuandoUnUsuarioEscribeMkDirEnLaTerminal_creaUnaCarpetaEnElDirectorio

	"Setup"
	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Exersice" 
	unaTerminal mkdir: carpetaTomas .

	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert isTrue: (unaTerminal tieneCarpetasEnElDirectorioActual).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:42'!
test013_cuandoUnUsuarioEscribeMkDirEnLaTerminal_noPuedeCrearUnaCarpetaYaExistente

	| unaTerminal unaCarpetaNueva |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaNueva _ carpetaTomas .

	"Exersice" 
	unaTerminal mkdir: unaCarpetaNueva .
	unaTerminal cd: unaCarpetaNueva .

	"Assert"
	Assert isFalse: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert that: (unaTerminal directorioActual) isEqualTo: unaCarpetaNueva .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:48'!
test014_cuandoUnUsuarioEscribeCDEnLaTerminal_noPuedeIngresarAUnaCarpetaInexistente

	| unaTerminal unaCarpeta |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpeta _ carpetaTomas .

	"Assert"
	Assert
        should: [unaTerminal cd: unaCarpeta .]
        signal: Error
        withDescription: self errorPorCarpetaInexistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:42:56'!
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
	Assert that: (unaTerminal directorioActual) isEqualTo: unaCarpetaNueva .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:01'!
test016_cuandoUnUsuarioEscribeCDParaVolverEnLaTerminal_esteNoPuedeRegresarALaCarpetaAnterior_porEstarEnElDirectorioRoot

	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cd .]
        signal: Error
        withDescription: self errorNoSePuedeRetrocederDesdeRoot .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:07'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:15'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:21'!
test019_cuandoUnUsuarioEscribeElComandoTouch_esteCreaUnArchivo

	| unaTerminal unArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoNuevo _ File conNombre: 'Archivo1.txt' .
	
	"Exercise"
	unaTerminal touch: unArchivoNuevo.
	
	"Assert"
	Assert isTrue: (unaTerminal tieneElArchivoEnElDirectorioActual: unArchivoNuevo).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:28'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:34'!
test021_cuandoUnUsuarioListaElContenidoDelDirectorio_conElComandoLS_esteListaTodosLosArchivosYLasCarpetas

	| unaTerminal listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivosYCarpetas .
	listaDeArchivosYCarpetas _ Set new.
	listaDeArchivosYCarpetas add: archivoDeTexto2 .
	listaDeArchivosYCarpetas add: carpetaTomas .
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:39'!
test022_cuandoUnUsuarioListaElContenidoDelDirectorio_conElComandoLS_noTieneNadaEnElDirectorioActual

	| unaTerminal listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	listaDeArchivosYCarpetas _ Set new.

	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:45'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:43:54'!
test024_cuandoUnUsuarioRootLeaUnArchivoDeText_esteMuestraElTexto

	| unaTerminal unaArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ archivoDeTexto .
	
	"Exercise"
	unaTerminal touch: unaArchivoNuevo .
	
	"Assert"
	Assert that: (unaTerminal cat: unaArchivoNuevo)  isEqualTo: ''.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:05'!
test025_cuandoUnUsuarioRootLeaUnArchivoDeText_esteNoExisteEnElDirectorioActual

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cat: archivoDeTexto]
        signal: Error
        withDescription: self errorPorArchivoInexistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:12'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:18'!
test027_cuandoUnUsuarioRootModifiqueUnArchivoDeTexto_esteNoExiste

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Assert"
	Assert
        should: [unaTerminal nano: archivoDeTexto edicion: 'Texto Modificado']
        signal: Error
        withDescription: self errorPorArchivoInexistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:23'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:30'!
test029_cuandoUnUsuarioFiltreUnArchivoPorTextoDado_esteNoEncuentraResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeTexto |
	
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	unFiltroDeTexto _ FilterText conElTexto: 'Texto no encontrado' .
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDeTexto } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:37'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:44'!
test031_cuandoUnUsuarioCreaUnArchivo_EsteLePertenece 
	
	"Setup"
	|unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
		
	"Assert"
	Assert that: archivoDeTexto creadoPorUsuario isEqualTo: unUserRootDefault .
	Assert isTrue:(archivoDeTexto fueCreadoPor: unUserRootDefault ).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:51'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:44:58'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:45:04'!
test034_cuandoUnUsuarioFiltreUnArchivoPorUnUsuarioDado_esteEncuentraNoResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeUsuario |
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	unFiltroDeUsuario _ FilterUser conElUsuario: unUserRootDiego4321.
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDeUsuario } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:45:12'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:45:18'!
test036_cuandoUnUsuarioRootLeeUnArchivoDeTexto_EsteTienePermisosDeLectura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.

	"Assert"
	Assert that: (unaTerminal cat: archivoDeTexto) isEqualTo: '' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:45:32'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:45:42'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:45:50'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:45:57'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:48:26'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:48:32'!
test042_cuandoUnUsuarioRootEjecuteUnArchivoDeTexto_esteTienePermisosDeEjecucion

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ejecutar: archivoDeTexto) isEqualTo: archivoDeTexto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:48:38'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:48:45'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:48:50'!
test045_cuandoUnUsuarioRootRemuevaUnArchivoDeTexto_esteTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal rm: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: Set new .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:48:56'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:03'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:10'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 00:50:29'!
test049_cuandoUnUsuarioRootLeAgregaUnPermisoDeLecturaAUnUsuario_estePuedeLeerElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 enElArchivo: archivoDeTexto.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	"Assert"
	Assert that: (unaTerminal cat: archivoDeTexto) isEqualTo: ''! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:20'!
test050_cuandoUnUsuarioRootLeAgregaUnPermisoDeLecturaAUnUsuario_esteYaTeniaPermisoParaLeerElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 enElArchivo: archivoDeTexto.
	
	"Assert"
	Assert
        should: [unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 enElArchivo: archivoDeTexto.]
        signal: Error
        withDescription: 'El usuario es owner/root o ya tiene permisos de lectura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:27'!
test051_cuandoUnUsuarioRootLeAgregaUnPermisoDeEscrituraAUnUsuario_estePuedeEscribirElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 enElArchivo: archivoDeTexto.
	unaTerminal agregarPermisosDeEscritura: unUserPublicDiego4321 enElArchivo: archivoDeTexto.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	unaTerminal nano: archivoDeTexto edicion: 'Texto Modificado' .
	
	"Assert"
	Assert that: (unaTerminal cat: archivoDeTexto) isEqualTo: 'Texto Modificado'! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:36'!
test052_cuandoUnUsuarioRootLeAgregaUnPermisoDeEscrituraAUnUsuario_esteYaTeniaPermisoParaEscribirElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeEscritura: unUserPublicDiego4321 enElArchivo: archivoDeTexto.
	
	"Assert"
	Assert
        should: [unaTerminal agregarPermisosDeEscritura: unUserPublicDiego4321 enElArchivo: archivoDeTexto.]
        signal: Error
        withDescription: 'El usuario es owner/root o ya tiene permisos de escritura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:42'!
test053_cuandoUnUsuarioRootLeAgregaUnPermisoDeEjecucionAUnUsuario_estePuedeEjecutarElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeEjecucion: unUserPublicDiego4321 enElArchivo: archivoDeTexto.
	
	"Assert"
	Assert that: (unaTerminal ejecutar: archivoDeTexto) isEqualTo: archivoDeTexto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:49'!
test054_cuandoUnUsuarioRootLeAgregaUnPermisoDeEjecucionAUnUsuario_esteYaTeniaPermisoParaEjecutarElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeEjecucion: unUserPublicDiego4321 enElArchivo: archivoDeTexto.
	
	"Assert"
	Assert
        should: [unaTerminal agregarPermisosDeEjecucion: unUserPublicDiego4321 enElArchivo: archivoDeTexto.]
        signal: Error
        withDescription: 'El usuario es owner/root o ya tiene permisos de ejecucion sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:49:55'!
test055_cuandoUnUsuarioSeElimineAElMismo_esteNoPuedeBorrarse

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserRootDiego1234.
	unaTerminal iniciarSesion: unUserRootDiego1234 .
	
	"Assert"
	Assert
        should: [unaTerminal borrarUsuario: unUserRootDiego1234 .]
        signal: Error
        withDescription: 'El usuario no puede borrarse a el mismo'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:02'!
test056_cuandoUnUsuarioRootLeAgregaUnPermisoDeEscrituraAUnUsuario_estePuedeEscribirEnLaCarpeta

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321. "Estamos parados sobre root"
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	unaTerminal mkdir: 	carpetaTomas .
	
	"Assert"
	Assert isTrue: unaTerminal esDirectoRaiz.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:10'!
test057_cuandoUnUsuarioRootLeAgregaUnPermisoDeEscrituraAUnUsuario_esteYaTeniaPermisoParaEscribirEnElDirectorio

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	
	"Assert"
	Assert
        should: [unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.]
        signal: Error
        withDescription: 'El usuario es owner/root o ya tiene permisos de escritura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:17'!
test058_cuandoUnUsuarioRootLeAgregaUnPermisoDeLecturaAUnUsuario_estePuedeLeerLaCarpetaDelDirectorio

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal mkdir: 	carpetaTomas .
	unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 paraLaCarpeta: carpetaTomas.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	unaTerminal cd: carpetaTomas .
	
	"Assert"
	Assert isFalse: unaTerminal esDirectoRaiz.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:24'!
test059_cuandoUnUsuarioRootLeAgregaUnPermisoDeLecturaAUnUsuario_esteTeniaPermisosDeLecturaParaLaCarpetaDelDirectorio

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal mkdir: 	carpetaTomas .
	unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 paraLaCarpeta: carpetaTomas.
	
	"Assert"
	Assert
        should: [unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 paraLaCarpeta: carpetaTomas.]
        signal: Error
        withDescription: 'El usuario es owner/root o ya tiene permisos de lectura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:31'!
test060_cuandoSeFiltreUnArchivoPorUnPermisoDado_esteEncuentraResultadoDeEscrituraPorqueEsUsuarioPublico

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDePermiso |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto2.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto2. 
	unFiltroDePermiso _ FilterPermissonEscritura conElUsuario: (unUserPublicDiego4321). 
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:40'!
test061_cuandoSeFiltreUnArchivoPorUnPermisoDado_esteEncuentraResultadoDeEscrituraPorqueEsUsuarioRoot

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDePermiso |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto2.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto.
	listaDeArchivosEncontrados add: archivoDeTexto2. 
	unFiltroDePermiso _ FilterPermissonEscritura conElUsuario: (unUserRootDiego1234). 
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:48'!
test062_cuandoSeFiltreUnArchivoPorUnPermisoDado_esteEncuentraResultadoDeLecturaPorqueEsUsuarioPublico

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDePermiso |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto2.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto2. 
	unFiltroDePermiso _ FilterPermissonLectura conElUsuario: (unUserPublicDiego4321).
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:50:55'!
test063_cuandoSeFiltreUnArchivoPorUnPermisoDado_esteEncuentraResultadoDeLecturaPorqueEsUsuarioRoot

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDePermiso |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto2.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto.
	listaDeArchivosEncontrados add: archivoDeTexto2. 
	unFiltroDePermiso _ FilterPermissonEscritura conElUsuario: (unUserRootDiego1234). 
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:51:07'!
test064_cuandoSeFiltreUnArchivoPorUnPermisoDado_esteEncuentraResultadoDeEjecucionPorqueEsUsuarioPublico

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDePermiso |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto2.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto2. 
	unFiltroDePermiso _ FilterPermissonEjecucion conElUsuario: (unUserPublicDiego4321).
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDePermiso } .	
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:51:19'!
test065_cuandoSeFiltreUnArchivoPorUnPermisoDado_esteEncuentraResultadoDeEscrituraPorqueEsUsuarioRoot

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDePermiso |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	unaTerminal touch: archivoDeTexto2.
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto.
	listaDeArchivosEncontrados add: archivoDeTexto2. 
	unFiltroDePermiso _ FilterPermissonEjecucion conElUsuario: (unUserRootDiego1234). 
	unFiltro _ FiltroCompuesto filtrarPor: { unFiltroDePermiso }.
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:51:22'!
test066_cuandoSeLeSacaPermisosDeEscrituraAUnUsuario_esteYaNoPuedeModificarElArchivo

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscritura: unUserPublicDiego4321 enElArchivo: archivoDeTexto .
	unaTerminal sacarPermisosDeEscrituraParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal nano: archivoDeTexto edicion: 'Texto Modificado']
        signal: Error
        withDescription: 'El usuario no tiene permisos de escritura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 00:55:33'!
test067_cuandoSeLeSacaPermisosDeLecturaAUnUsuario_esteYaNoPuedeLeerElArchivo

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 enElArchivo: archivoDeTexto .
	unaTerminal sacarPermisosDeLecturaParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal cat: archivoDeTexto]
        signal: Error
        withDescription: 'El usuario no tiene permisos de lectura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 00:55:08'!
test068_cuandoSeLeSacaPermisosDeEjecucionAUnUsuario_esteYaNoPuedeEjecutarElArchivo

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEjecucion: unUserPublicDiego4321 enElArchivo: archivoDeTexto .
	unaTerminal sacarPermisosDeEjecutarParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal ejecutar: archivoDeTexto]
        signal: Error
        withDescription: 'El usuario no tiene permisos de ejecucion'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 00:54:32'!
test069_cuandoSeLeSacaPermisosDeEscrituraAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermiso

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeEscrituraParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .]
        signal: Error
        withDescription: 'El usuario es root o no tiene permisos de escritura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 00:54:40'!
test070_cuandoSeLeSacaPermisosDeLecturaAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermiso

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeLecturaParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .]
        signal: Error
        withDescription: 'El usuario es root o no tiene permisos de lectura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 00:54:23'!
test071_cuandoSeLeSacaPermisosDeEjecucionAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermiso

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeEjecutarParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .]
        signal: Error
        withDescription: 'El usuario es root o no tiene permisos de ejecucion sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 01:03:50'!
test072_cuandoSeLeSacaPermisosDeLecturaAUnUsuario_esteYaNoPuedeLeerLaCarpeta

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal mkdir: carpetaDiego .
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeLectura: unUserPublicDiego4321 paraLaCarpeta: carpetaDiego .
	unaTerminal sacarPermisosDeLectura: unUserPublicDiego4321 paraLaCarpeta: carpetaDiego .
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal cd: carpetaDiego .]
        signal: Error
        withDescription: 'El usuario no tiene permisos de lectura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 01:08:13'!
test073_cuandoSeLeSacaPermisosDeEscrituraAUnUsuario_esteYaNoPuedeEscribirEnElDirectorio

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .
	unaTerminal sacarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal mkdir: carpetaDiego .]
        signal: Error
        withDescription: 'El usuario no tiene permisos de escritura'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 01:11:30'!
test074_cuandoSeLeSacaPermisosDeLecturaAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermisoALaCarpeta

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal mkdir: carpetaDiego .
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeLectura: unUserPublicDiego4321 paraLaCarpeta: carpetaDiego .]
        signal: Error
        withDescription: 'El usuario es root o no tiene permisos de lectura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 01:12:05'!
test075_cuandoSeLeSacaPermisosDeEscrituraAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermisoALaCarpeta

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .]
        signal: Error
        withDescription: 'El usuario es root o no tiene permisos de escritura sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/24/2021 17:33:43'!
test076_cuandoUnUsuarioIniciaSesion_esteSiempreEmpiezaEnLaCarpetaRoot

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal mkdir: carpetaTomas .
	unaTerminal cd: carpetaTomas .
	unaTerminal ingresarUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	Assert isTrue: unaTerminal estaParadaEnElDirectorioRaiz .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 00:39:36'!
test077_cuandoUnUsuarioPropietarioDelArchivo_agregaPermisosDeEjecucionAUnUsuarioSobreUnArchivo_esteTienePermisosParaEjecutarlo

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal ingresarUsuario: unUserPublicTomas4321 .
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	unaTerminal touch: archivoDeTexto .
	unaTerminal agregarPermisosDeEjecucion: unUserPublicTomas4321 enElArchivo: archivoDeTexto .
	unaTerminal iniciarSesion: unUserPublicTomas4321 .
	
	Assert that: (unaTerminal ejecutar: archivoDeTexto) isEqualTo: archivoDeTexto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:12:55'!
test078_cuandoUnUsuarioPropietarioDelArchivo_agregaPermisosDeEjecucionAUnUsuarioSobreUnArchivo_esteNoPuedeDarlePermisosPorqueNoEsOwner

	| unaTerminal unUsuarioJuancito |
	"Setup"
	unUsuarioJuancito _ PublicUser conNombre: 'Juancito' yContraseña: '123' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal ingresarUsuario: unUserPublicTomas4321 .
	unaTerminal ingresarUsuario: (unUsuarioJuancito) .
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	unaTerminal touch: archivoDeTexto .
	unaTerminal iniciarSesion: unUserPublicTomas4321 .
	
	Assert
        should: [unaTerminal agregarPermisosDeEjecucion: unUsuarioJuancito enElArchivo: archivoDeTexto .]
        signal: Error
        withDescription: 'El usuario es owner/root o ya tiene permisos de ejecucion sobre este archivo/carpeta'.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:02:41'!
test079_cuandoUnUsuarioPropietarioDeLaCarpeta_agregaPermisosDeLecturaAUnUsuario_esteTienePermisosParaLeer

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal ingresarUsuario: unUserPublicTomas4321 .
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .
	unaTerminal mkdir: carpetaDiego .

	unaTerminal agregarPermisosDeLectura: unUserPublicTomas4321 paraLaCarpeta: carpetaDiego .
	unaTerminal iniciarSesion: unUserPublicTomas4321 .
	unaTerminal cd: carpetaDiego .
	
	Assert isFalse: unaTerminal esDirectoRaiz .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:08:28'!
test080_cuandoUnUsuarioPropietarioDeLaCarpeta_agregaPermisosDeEscrituraAUnUsuario_esteTienePermisosParaEscribir

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal ingresarUsuario: unUserPublicTomas4321 .
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .
	unaTerminal mkdir: carpetaDiego .
	unaTerminal agregarPermisosDeLectura: unUserPublicTomas4321 paraLaCarpeta: carpetaDiego .
	unaTerminal cd: carpetaDiego .
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicTomas4321.

	unaTerminal iniciarSesion: unUserPublicTomas4321 .
	unaTerminal cd: carpetaDiego .
	unaTerminal mkdir: carpetaTomas .
	
	Assert isFalse: unaTerminal esDirectoRaiz .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/25/2021 01:17:28'!
test081_cuandoUnUsuarioRoot_quieraAgregarPermisosAUnUsuarioInexistente_esteNoPuede

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	Assert
        should: [unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .]
        signal: Error
        withDescription: 'El usuario no existe'.! !


!TerminalTest methodsFor: 'setUp/tearDown' stamp: 'dk 11/25/2021 01:41:11'!
setUp

	unUserRootDefault _ RootUser conNombre: 'root' yContraseña: 'root' .
	unUserRootDiego1234 _ RootUser conNombre: 'Diego' yContraseña: '1234' .
	unUserRootDiego4321 _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	unUserPublicDiego4321 _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unUserPublicTomas4321 _ PublicUser conNombre: 'Tomas' yContraseña: '4321' .
	
	carpetaTomas _ Folder	 conNombre: 'Tomas' .
	carpetaDiego _ Folder	 conNombre: 'Diego' .
	
	archivoDeTexto _ File conNombre: 'Archivo1.txt' .
	archivoDeTexto2 _ File conNombre: 'Archivo2.txt' .
	
	filtroDeTexto _ FilterText conElTexto: 'Texto Modificado' .
	filtroDeFecha _ FilterCreationFile conLaFecha: FixedGregorianDate today .
	
	filtroCompuestoPorTexto _ FiltroCompuesto filtrarPor: { filtroDeTexto } .
	filtroCompuestoPorFecha _ FiltroCompuesto filtrarPor: { filtroDeFecha } .
	filtroCompuestoPorTextoYFecha _ FiltroCompuesto filtrarPor: { filtroDeTexto . filtroDeFecha } .! !


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

!FilterCreationFile methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:21:32'!
initializeConLaFecha: unaFechaDeCreacion 

	fechaDeCreacion _ unaFechaDeCreacion.! !


!FilterCreationFile methodsFor: 'testing' stamp: 'dk 11/25/2021 01:21:38'!
puedeFiltrar: unArchivo

	^ (fechaDeCreacion = unArchivo fechaDeCreacion).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterCreationFile class' category: 'Grupo1-TP-Final'!
FilterCreationFile class
	instanceVariableNames: ''!

!FilterCreationFile class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:59'!
conLaFecha: unaFechaDeCreacion

	^self new initializeConLaFecha: unaFechaDeCreacion. ! !


!classDefinition: #FilterPermisson category: 'Grupo1-TP-Final'!
Filter subclass: #FilterPermisson
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!


!classDefinition: #FilterPermissonEjecucion category: 'Grupo1-TP-Final'!
FilterPermisson subclass: #FilterPermissonEjecucion
	instanceVariableNames: 'usuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterPermissonEjecucion methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:23:44'!
initializeConElUsuario: unUsuario 

	usuario _ unUsuario.! !


!FilterPermissonEjecucion methodsFor: 'testing' stamp: 'dk 11/25/2021 01:23:49'!
puedeFiltrar: unArchivo 

	 ^ (unArchivo tienePermisosDeEjecucionDelUsuario: usuario) | (usuario isMemberOf: RootUser).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterPermissonEjecucion class' category: 'Grupo1-TP-Final'!
FilterPermissonEjecucion class
	instanceVariableNames: ''!

!FilterPermissonEjecucion class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:53'!
conElUsuario: unUsuario 

	^self new initializeConElUsuario: unUsuario. ! !


!classDefinition: #FilterPermissonEscritura category: 'Grupo1-TP-Final'!
FilterPermisson subclass: #FilterPermissonEscritura
	instanceVariableNames: 'usuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterPermissonEscritura methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:24:00'!
initializeConElUsuario: unUsuario 

	usuario _ unUsuario.! !


!FilterPermissonEscritura methodsFor: 'testing' stamp: 'dk 11/25/2021 01:24:04'!
puedeFiltrar: unArchivo 

	 ^ (unArchivo tienePermisosDeEscrituraDelUsuario: usuario) | (usuario isMemberOf: RootUser).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterPermissonEscritura class' category: 'Grupo1-TP-Final'!
FilterPermissonEscritura class
	instanceVariableNames: ''!

!FilterPermissonEscritura class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:50'!
conElUsuario: unUsuario 

	^self new initializeConElUsuario: unUsuario.! !


!classDefinition: #FilterPermissonLectura category: 'Grupo1-TP-Final'!
FilterPermisson subclass: #FilterPermissonLectura
	instanceVariableNames: 'usuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterPermissonLectura methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:24:10'!
initializeConElUsuario: unUsuario .

	usuario _ unUsuario.! !


!FilterPermissonLectura methodsFor: 'testing' stamp: 'dk 11/25/2021 01:24:14'!
puedeFiltrar: unArchivo

	^ (unArchivo tienePermisosDeLecturaDelUsuario: usuario) | (usuario isMemberOf: RootUser).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterPermissonLectura class' category: 'Grupo1-TP-Final'!
FilterPermissonLectura class
	instanceVariableNames: ''!

!FilterPermissonLectura class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:45'!
conElUsuario: unUsuario 

	^self new initializeConElUsuario: unUsuario. ! !


!classDefinition: #FilterText category: 'Grupo1-TP-Final'!
Filter subclass: #FilterText
	instanceVariableNames: 'texto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterText methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:21:46'!
initializeConElTexto: unTexto 

	texto _ unTexto.! !


!FilterText methodsFor: 'testing' stamp: 'dk 11/25/2021 01:21:50'!
puedeFiltrar: unArchivo 

	^ (unArchivo texto  = texto).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterText class' category: 'Grupo1-TP-Final'!
FilterText class
	instanceVariableNames: ''!

!FilterText class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:41'!
conElTexto: unTexto 

	^self new initializeConElTexto: unTexto ! !


!classDefinition: #FilterUser category: 'Grupo1-TP-Final'!
Filter subclass: #FilterUser
	instanceVariableNames: 'usuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterUser methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:21:59'!
initializeConElUsuario: unUsuario 

	usuario _ unUsuario.! !


!FilterUser methodsFor: 'testing' stamp: 'dk 11/25/2021 01:22:05'!
puedeFiltrar: unArchivo

	^ unArchivo creadoPorUsuario nombre = usuario nombre.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterUser class' category: 'Grupo1-TP-Final'!
FilterUser class
	instanceVariableNames: ''!

!FilterUser class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:38'!
conElUsuario: unUsuario

	^self new initializeConElUsuario: unUsuario. ! !


!classDefinition: #FiltroCompuesto category: 'Grupo1-TP-Final'!
Filter subclass: #FiltroCompuesto
	instanceVariableNames: 'listaDeFiltros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FiltroCompuesto methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:22:15'!
initializeFiltrarPor: unaListaDeFiltros 

	listaDeFiltros _ unaListaDeFiltros.! !


!FiltroCompuesto methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:22:19'!
filtrarArchivosEnElDirectorio: unaColeccionDeArchivos

	^ unaColeccionDeArchivos select: [: unArchivo| listaDeFiltros allSatisfy:[: unFiltro| unFiltro puedeFiltrar: unArchivo] ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FiltroCompuesto class' category: 'Grupo1-TP-Final'!
FiltroCompuesto class
	instanceVariableNames: ''!

!FiltroCompuesto class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:33'!
filtrarPor: unaListaDeFiltros
	
	^self new initializeFiltrarPor: unaListaDeFiltros. ! !


!classDefinition: #Permiso category: 'Grupo1-TP-Final'!
Object subclass: #Permiso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!


!classDefinition: #PermisoDeEjecucion category: 'Grupo1-TP-Final'!
Permiso subclass: #PermisoDeEjecucion
	instanceVariableNames: 'listaDeUsuariosQuePuedenEjecutar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PermisoDeEjecucion methodsFor: 'testing' stamp: 'dk 11/25/2021 01:25:48'!
puedeEjecutar: unUsuario 

	^ listaDeUsuariosQuePuedenEjecutar anySatisfy: [:unUsuarioEnLaLista | unUsuario nombreEsIgual: unUsuarioEnLaLista nombre]! !


!PermisoDeEjecucion methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:25:44'!
initialize

	listaDeUsuariosQuePuedenEjecutar _ Set new .! !


!PermisoDeEjecucion methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:25:36'!
agregar: unUsuario 
	
	listaDeUsuariosQuePuedenEjecutar add: unUsuario ! !

!PermisoDeEjecucion methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:42:22'!
sacar: unUsuario 
	
	| usuarioABorrar |
	usuarioABorrar _ listaDeUsuariosQuePuedenEjecutar detect: [:unUsuarioEnLaLista | unUsuarioEnLaLista nombreEsIgual: unUsuario nombre] .
	
	listaDeUsuariosQuePuedenEjecutar remove: usuarioABorrar .! !


!classDefinition: #PermisoDeEscritura category: 'Grupo1-TP-Final'!
Permiso subclass: #PermisoDeEscritura
	instanceVariableNames: 'listaDeUsuariosQuePuedenEscribir'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PermisoDeEscritura methodsFor: 'testing' stamp: 'dk 11/25/2021 01:25:52'!
puedeEscribir: unUsuario 

	^ (listaDeUsuariosQuePuedenEscribir anySatisfy: [:unUsuarioEnLaLista | unUsuario nombreEsIgual: unUsuarioEnLaLista nombre])! !


!PermisoDeEscritura methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:25:56'!
initialize

	listaDeUsuariosQuePuedenEscribir _ Set new ! !


!PermisoDeEscritura methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:26:00'!
agregar: unUsuario

	listaDeUsuariosQuePuedenEscribir add: unUsuario.! !

!PermisoDeEscritura methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:40:40'!
sacar: unUsuario 
	
	| usuarioABorrar |
	usuarioABorrar _ listaDeUsuariosQuePuedenEscribir detect: [:unUsuarioEnLaLista | unUsuarioEnLaLista nombreEsIgual: unUsuario nombre] .
	
	listaDeUsuariosQuePuedenEscribir remove: usuarioABorrar .! !


!classDefinition: #PermisoDeLectura category: 'Grupo1-TP-Final'!
Permiso subclass: #PermisoDeLectura
	instanceVariableNames: 'listaDeUsuariosQuePuedenLeer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PermisoDeLectura methodsFor: 'testing' stamp: 'dk 11/25/2021 01:26:07'!
initialize

	listaDeUsuariosQuePuedenLeer _ Set new .! !

!PermisoDeLectura methodsFor: 'testing' stamp: 'dk 11/25/2021 01:26:10'!
puedeLeer: unUser 

	^ listaDeUsuariosQuePuedenLeer anySatisfy: [:unUsuarioEnLaLista | unUser nombreEsIgual: unUsuarioEnLaLista nombre]! !


!PermisoDeLectura methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:26:18'!
agregar: unUsuario 
	
	listaDeUsuariosQuePuedenLeer add: unUsuario ! !

!PermisoDeLectura methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:42:02'!
sacar: unUsuario 
	
	| usuarioABorrar |
	usuarioABorrar _ listaDeUsuariosQuePuedenLeer detect: [:unUsuarioEnLaLista | unUsuarioEnLaLista nombreEsIgual: unUsuario nombre] .
	
	listaDeUsuariosQuePuedenLeer remove: usuarioABorrar .! !


!classDefinition: #SistemaDeArchivos category: 'Grupo1-TP-Final'!
Object subclass: #SistemaDeArchivos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!


!classDefinition: #File category: 'Grupo1-TP-Final'!
SistemaDeArchivos subclass: #File
	instanceVariableNames: 'nombre fechaDeCreacion fechaDeModificacion texto creadoPorUsuario permisosDeLectura permisosDeEscritura permisosDeEjecucion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!File methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:19:38'!
initialize

	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.

	texto _ '' .
	permisosDeLectura _ PermisoDeLectura new.
	permisosDeEscritura _ PermisoDeEscritura new.
	permisosDeEjecucion _ PermisoDeEjecucion new.! !

!File methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:19:44'!
initializeConNombre: unNombre 

	nombre _ unNombre.! !


!File methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:19:50'!
creadoPorUsuario

	^ creadoPorUsuario.! !

!File methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:19:53'!
fechaDeCreacion

	^fechaDeCreacion! !

!File methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:19:56'!
fechaDeModificacion

	^ fechaDeModificacion! !

!File methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:20:01'!
nombre

	^nombre! !

!File methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:20:04'!
texto

	^ texto! !


!File methodsFor: 'testing' stamp: 'dk 11/25/2021 01:20:09'!
fueCreadoPor: unUsuario 

	^ (creadoPorUsuario nombre = unUsuario nombre).! !

!File methodsFor: 'testing' stamp: 'dk 11/25/2021 01:21:15'!
nombreEsIgual: nombreArchivo

	^ (nombre = nombreArchivo) ! !

!File methodsFor: 'testing' stamp: 'dk 11/25/2021 01:21:19'!
tienePermisosDeEjecucionDelUsuario: unUsuario 

	^ (permisosDeEjecucion puedeEjecutar: unUsuario)! !

!File methodsFor: 'testing' stamp: 'dk 11/25/2021 01:21:21'!
tienePermisosDeEscrituraDelUsuario: unUsuario 

	^ (permisosDeEscritura puedeEscribir: unUsuario)! !

!File methodsFor: 'testing' stamp: 'dk 11/25/2021 01:21:25'!
tienePermisosDeLecturaDelUsuario: unUsuario

	^(permisosDeLectura puedeLeer: unUsuario)! !


!File methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:18:47'!
agregarPermisosParaEjecutar: unUsuario 
	
	permisosDeEjecucion agregar: unUsuario.! !

!File methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:18:51'!
agregarPermisosParaEscribir: unUsuario 

	permisosDeEscritura agregar: unUsuario.! !

!File methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:18:55'!
agregarPermisosParaLeer: unUsuario 
	
	permisosDeLectura agregar: unUsuario.! !

!File methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:19:19'!
creadoPor: unUsuario

	creadoPorUsuario _ unUsuario.
	
	(unUsuario isMemberOf: PublicUser) 
	ifTrue:[ 
		permisosDeEjecucion agregar: unUsuario.
		permisosDeEscritura  agregar: unUsuario.
		permisosDeLectura    agregar: unUsuario.
	].
! !

!File methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:19:27'!
modificarTexto: unTexto 

	texto _ unTexto .! !

!File methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:42:52'!
sacarPermisosParaEjecutar: unUsuario 
	
	permisosDeEjecucion sacar: unUsuario ! !

!File methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:35:15'!
sacarPermisosParaEscribir: unUsuario 
	
	permisosDeEscritura sacar: unUsuario ! !

!File methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:42:42'!
sacarPermisosParaLeer: unUsuario 
	
	permisosDeLectura sacar: unUsuario ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'File class' category: 'Grupo1-TP-Final'!
File class
	instanceVariableNames: ''!

!File class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:40:06'!
conNombre: unNombre

	^self new initializeConNombre: unNombre. ! !


!classDefinition: #Folder category: 'Grupo1-TP-Final'!
SistemaDeArchivos subclass: #Folder
	instanceVariableNames: 'nombreCarpeta listaDeCarpetas listaDeArchivos fechaDeCreacion fechaDeModificacion permisosDeLectura permisosDeEscritura permisosDeEjecucion creadoPorUsuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Folder methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:25:20'!
inicializarConNombre: unNombre

	nombreCarpeta _ unNombre.! !

!Folder methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:25:27'!
initialize

	listaDeCarpetas _ Set new.
	listaDeArchivos _ Set new. 
	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.
	
	permisosDeLectura _ PermisoDeLectura new.
	permisosDeEscritura _ PermisoDeEscritura new.! !


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


!Folder methodsFor: 'testing' stamp: 'dk 11/25/2021 01:24:57'!
nombreEsIgual: unNombre

	^ nombreCarpeta = unNombre.! !

!Folder methodsFor: 'testing' stamp: 'dk 11/25/2021 01:25:02'!
tieneArchivos

	^ listaDeArchivos notEmpty.! !

!Folder methodsFor: 'testing' stamp: 'dk 11/25/2021 01:25:05'!
tieneCarpetas

	^ listaDeCarpetas notEmpty.! !

!Folder methodsFor: 'testing' stamp: 'dk 11/25/2021 01:25:08'!
tienePermisosDeEscrituraDelUsuario: unUsuario 

	^ (permisosDeEscritura puedeEscribir: unUsuario)! !

!Folder methodsFor: 'testing' stamp: 'dk 11/25/2021 01:25:12'!
tienePermisosDeLecturaDelUsuario: unUsuario 
	
	^ (permisosDeLectura puedeLeer: unUsuario)! !


!Folder methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:24:38'!
agregarCarpeta: unaCarpeta 

	listaDeCarpetas add: unaCarpeta.! !

!Folder methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:24:43'!
agregarPermisosParaEscribir: unUsuario 

	permisosDeEscritura agregar: unUsuario.! !

!Folder methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:24:47'!
agregarPermisosParaLeer: unUsuario 
	
	permisosDeLectura agregar: unUsuario.! !

!Folder methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:24:50'!
creadoPor: unUsuario

	creadoPorUsuario _ unUsuario! !

!Folder methodsFor: 'public actions' stamp: 'dk 11/24/2021 01:00:32'!
sacarPermisosParaEscribir: unUsuario 
	
	permisosDeEscritura sacar: unUsuario ! !

!Folder methodsFor: 'public actions' stamp: 'dk 11/24/2021 01:00:05'!
sacarPermisosParaLeer: unUsuario 
	
	permisosDeLectura sacar: unUsuario ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Folder class' category: 'Grupo1-TP-Final'!
Folder class
	instanceVariableNames: ''!

!Folder class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:26'!
conNombre: unNombre

	^self new inicializarConNombre: unNombre.! !


!classDefinition: #Terminal category: 'Grupo1-TP-Final'!
Object subclass: #Terminal
	instanceVariableNames: 'listaDeUsuarios usuarioLogueado directorioActual listaDeDirectoriosVistos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:31:42'!
initialize

	| defaultUserRoot |
	defaultUserRoot _ RootUser conNombre: 'root' yContraseña: 'root'.
	listaDeUsuarios _ Set new .
	listaDeUsuarios add: defaultUserRoot .	
	directorioActual _ Folder conNombre: 'root' .
	directorioActual creadoPor: defaultUserRoot .
	
	listaDeDirectoriosVistos _ OrderedCollection new .
	listaDeDirectoriosVistos add: directorioActual .! !

!Terminal methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:31:48'!
initializeIniciarSesion: unUser 

	self iniciarSesion: unUser .
	! !


!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:31:58'!
elArchivo: unArchivo existeEnElDirectorioActual: unaListaDeArchivos

	(unaListaDeArchivos anySatisfy: [:unArchivoEnLaLista| unArchivoEnLaLista nombreEsIgual: unArchivo nombre]) 
		ifTrue:[self errorArchivoExistente]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:01'!
elDirectorioActualFueCreadoPorElUsuarioLogueado

	^ (directorioActual creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre))! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:04'!
elDirectorioActualFueCreadoPorElUsuarioLogueadoOElUsuarioEsRoot

	^ self elDirectorioActualFueCreadoPorElUsuarioLogueado | (self elUsuarioLogueadoEsRoot)! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:06'!
elUsuarioLogueadoCreoEl: unArchivo

	^ (unArchivo creadoPorUsuario nombreEsIgual: (usuarioLogueado nombre))! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:09'!
elUsuarioLogueadoEsRoot

	^ (usuarioLogueado isMemberOf: RootUser)! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:12'!
elUsuarioLogueadoEsRootOCreoEl: unArchivo

	^ (self elUsuarioLogueadoCreoEl: unArchivo) | (self elUsuarioLogueadoEsRoot)! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:15'!
esDirectoRaiz

	^ listaDeDirectoriosVistos size = 1! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:17'!
estaElUsuarioLogueado: unUser 

	^ unUser esIgualElUserYContraseñaA: usuarioLogueado ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:20'!
estaParadaEnElDirectorioRaiz

	^ self esDirectoRaiz .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:25'!
existeEnElDirectorioActualUnaCarpetaConElMismoNombreA: unaCarpeta

	|listaDeCarpetasEnElDirectorioActual|
	listaDeCarpetasEnElDirectorioActual _ directorioActual listaDeCarpetas.

	 (listaDeCarpetasEnElDirectorioActual anySatisfy: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista]) 
		ifTrue: [self errorLaCarpetaYaExiste] ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:28'!
existeEnLaListaDeUsuariosEl: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | (unUserEnLaLista nombreEsIgual: unUser nombre)]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:31'!
tieneAlUsuario: unUser 

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | unUserEnLaLista nombreEsIgual: unUser nombre] .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:33'!
tieneAlUsuarioLogueado: unUsuario 

	^ (self tieneUnUsuarioLogueado) & (self estaElUsuarioLogueado: unUsuario) .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:36'!
tieneCarpetasEnElDirectorioActual

	^ directorioActual tieneCarpetas.! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:39'!
tieneElArchivoEnElDirectorioActual: unArchivo

	^ (directorioActual listaDeArchivos) includes: unArchivo.! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:41'!
tieneUnUsuarioLogueado

	^ usuarioLogueado notNil ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:44'!
unUsuarioTieneElMismoNombreYContraseñaQue: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | unUserEnLaLista esIgualElUserYContraseñaA: unUser]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/25/2021 01:32:47'!
unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista

	^ unaCarpetaEnLaLista nombreEsIgual: (unaCarpeta nombre)! !


!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:26:46'!
agregarCarpetaEnElDirectorio: unaCarpeta

	^ directorioActual agregarCarpeta: unaCarpeta! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:35:25'!
agregarPermisosDeEjecucion: unUsuario enElArchivo: unArchivo	

	|listaDeArchivosEnElDirectorioActual unArchivoEncontrado unUsuarioEncontrado |
	listaDeArchivosEnElDirectorioActual _ directorioActual listaDeArchivos.
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo en: listaDeArchivosEnElDirectorioActual .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
		
	 ((unArchivoEncontrado tienePermisosDeEjecucionDelUsuario: unUsuario) 
	| (unUsuarioEncontrado isMemberOf: RootUser)
	| (usuarioLogueado noEsPropietarioDe: unArchivoEncontrado) )
	ifTrue:[self error: 'El usuario es owner/root o ya tiene permisos de ejecucion sobre este archivo/carpeta'].
	
	usuarioLogueado agregarPermisosParaEjecutar: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:35:30'!
agregarPermisosDeEscritura: unUsuario enElArchivo: unArchivo
	
	|listaDeArchivosEnElDirectorioActual unArchivoEncontrado unUsuarioEncontrado |
	
	listaDeArchivosEnElDirectorioActual _ directorioActual listaDeArchivos.
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo en: listaDeArchivosEnElDirectorioActual .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
		
	((unArchivoEncontrado tienePermisosDeEscrituraDelUsuario: unUsuario) 
	| (unUsuarioEncontrado isMemberOf: RootUser)
	| (usuarioLogueado noEsPropietarioDe: unArchivoEncontrado))
	ifTrue:[self error: 'El usuario es owner/root o ya tiene permisos de escritura sobre este archivo/carpeta'].
	
	usuarioLogueado agregarPermisosParaEscribir: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:33:39'!
agregarPermisosDeEscrituraEnElDirectorioPara: unUsuario 

	| unUsuarioEncontrado |
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
		
	 ((directorioActual tienePermisosDeEscrituraDelUsuario: unUsuarioEncontrado) 
	| (unUsuarioEncontrado isMemberOf: RootUser)
	| (usuarioLogueado noEsPropietarioDe: directorioActual))
	ifTrue:[self error: 'El usuario es owner/root o ya tiene permisos de escritura sobre este archivo/carpeta'].
	
	usuarioLogueado agregarPermisosParaEscribir: directorioActual para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:35:34'!
agregarPermisosDeLectura: unUsuario enElArchivo: unArchivo

	|listaDeArchivosEnElDirectorioActual unArchivoEncontrado unUsuarioEncontrado |
	
	listaDeArchivosEnElDirectorioActual _ directorioActual listaDeArchivos.
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo en: listaDeArchivosEnElDirectorioActual .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
		
	 ((unArchivoEncontrado tienePermisosDeLecturaDelUsuario: unUsuarioEncontrado) 
	| (unUsuarioEncontrado isMemberOf: RootUser)
	| (usuarioLogueado noEsPropietarioDe: unArchivoEncontrado))
	ifTrue:[self error: 'El usuario es owner/root o ya tiene permisos de lectura sobre este archivo/carpeta'].
	
	usuarioLogueado agregarPermisosParaLeer: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:33:39'!
agregarPermisosDeLectura: unUsuario paraLaCarpeta: unaCarpeta 

	|carpetaEncontrada unUsuarioEncontrado |
	
	carpetaEncontrada _ self obtenerCarpetaDelDirectorioActual: unaCarpeta.
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	((carpetaEncontrada tienePermisosDeLecturaDelUsuario: unUsuarioEncontrado) 
	| (carpetaEncontrada creadoPorUsuario nombreEsIgual: (unUsuarioEncontrado nombre)) 
	| (unUsuarioEncontrado isMemberOf: RootUser)
	| (usuarioLogueado noEsPropietarioDe: carpetaEncontrada))
	ifTrue:[self error: 'El usuario es owner/root o ya tiene permisos de lectura sobre este archivo/carpeta'].
	
	usuarioLogueado agregarPermisosParaLeer: carpetaEncontrada para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:27:12'!
borrarUsuario: unUser 

	((usuarioLogueado nombre) = (unUser nombre)) 
		ifTrue: [self error: 'El usuario no puede borrarse a el mismo'] .
	
	listaDeUsuarios remove: unUser 
		ifAbsent: [self errorUsuarioNoExistente]! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:27:25'!
cd
	
	(self esDirectoRaiz ) 
		ifTrue: [
			self error: 'No se puede volver, estas parado en root'
		] ifFalse: [
			listaDeDirectoriosVistos removeLast .
			directorioActual _ listaDeDirectoriosVistos last .	
		]
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/24/2021 01:05:39'!
cd: unaCarpeta 
	
	| carpetaSiguiente |
	carpetaSiguiente _ self obtenerCarpetaDelDirectorioActual: unaCarpeta.

	( (carpetaSiguiente tienePermisosDeLecturaDelUsuario: usuarioLogueado) 
		| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de lectura'].

	listaDeDirectoriosVistos add: carpetaSiguiente .
	directorioActual _ (listaDeDirectoriosVistos last) .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:27:43'!
ejecutar: unArchivo 
	"Ejecucion en nuestro dominion no hace nada solo devolver el archivo. Solo se fija si existe y el usuario tiene permisos de ejecucion"
	
	| listaDeArchivos  archivo|
	listaDeArchivos _ directorioActual listaDeArchivos .
	
	archivo _ self obtenerArchivo: unArchivo en: listaDeArchivos .
		
	( (archivo tienePermisosDeEjecucionDelUsuario: usuarioLogueado) 
		| (self elUsuarioLogueadoEsRootOCreoEl: archivo) )
		ifFalse: [self error: 'El usuario no tiene permisos de ejecucion'].
		
	^ archivo .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:27:47'!
errorArchivoExistente

	^ self error: 'No se puede crear un archivo con el mismo nombre'! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:27:50'!
filtrarCon: filtro

	^ (filtro filtrarArchivosEnElDirectorio: directorioActual listaDeArchivos). ! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:27:55'!
ingresarUsuario: unUserAIngresar
	
	(self existeEnLaListaDeUsuariosEl: unUserAIngresar) 
		ifTrue: [self errorContraseñaOUsuarioIncorrecto] 
		ifFalse: [listaDeUsuarios add: unUserAIngresar].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:28:02'!
iniciarSesion: unUserALoguease 
	
	(self unUsuarioTieneElMismoNombreYContraseñaQue: unUserALoguease) 
		ifTrue: [
			usuarioLogueado _ unUserALoguease .
			listaDeDirectoriosVistos _ OrderedCollection with: (listaDeDirectoriosVistos first).
			directorioActual _ listaDeDirectoriosVistos first.
			] 
		ifFalse: [self errorContraseñaOUsuarioIncorrecto].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:28:28'!
mkdir: unaCarpeta

	self existeEnElDirectorioActualUnaCarpetaConElMismoNombreA: unaCarpeta .
	
	( ((directorioActual tienePermisosDeEscrituraDelUsuario: usuarioLogueado) ) 
	| ((directorioActual creadoPorUsuario nombre = usuarioLogueado nombre) & (self esDirectoRaiz) ) 
	| (usuarioLogueado isMemberOf: RootUser) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
	
	unaCarpeta creadoPor: usuarioLogueado .
	self agregarCarpetaEnElDirectorio: unaCarpeta! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:29:14'!
modificarUsuario: unUserAModificar por: unUserConModificaciones 

	| usuarioEncontrado |
	usuarioEncontrado _ self obtenerUsuario: unUserAModificar .
		
	usuarioEncontrado modificarPor: unUserConModificaciones .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:29:37'!
nano: unArchivo edicion: unTexto
	
	| listaDeArchivos archivoAModificar |
	listaDeArchivos _ directorioActual listaDeArchivos .
	
	archivoAModificar _ self obtenerArchivo: unArchivo en: listaDeArchivos .
		
	( (archivoAModificar tienePermisosDeEscrituraDelUsuario: usuarioLogueado) 
	| (self elUsuarioLogueadoEsRootOCreoEl: archivoAModificar) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
		
	archivoAModificar modificarTexto: unTexto .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:29:47'!
rm: unArchivoABorrar

	|archivoABorrar listaDeArchivos|
	listaDeArchivos _ directorioActual listaDeArchivos.
	
	archivoABorrar _ self obtenerArchivo: unArchivoABorrar en: listaDeArchivos.
	
	( (archivoABorrar tienePermisosDeEscrituraDelUsuario: usuarioLogueado) 
	| (self elUsuarioLogueadoEsRootOCreoEl: archivoABorrar) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
	
	directorioActual listaDeArchivos remove: archivoABorrar.
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:38:03'!
sacarPermisosDeEjecutarParaElArchivo: unArchivo alUsuario: unUsuario
	
	| listaDeArchivosEnElDirectorioActual unArchivoEncontrado unUsuarioEncontrado |
	listaDeArchivosEnElDirectorioActual _ directorioActual listaDeArchivos.
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo en: listaDeArchivosEnElDirectorioActual .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	((unArchivoEncontrado tienePermisosDeEjecucionDelUsuario: unUsuarioEncontrado) 
	& (unUsuarioEncontrado isMemberOf: PublicUser) 
	& (unUsuarioEncontrado noEsPropietarioDe: unArchivoEncontrado))
	ifFalse:[self error: 'El usuario es root o no tiene permisos de ejecucion sobre este archivo/carpeta'].
	
	usuarioLogueado sacarPermisosParaEjecutar: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:38:28'!
sacarPermisosDeEscrituraEnElDirectorioPara: unUsuario 

	| unUsuarioEncontrado |
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	((directorioActual tienePermisosDeEscrituraDelUsuario: unUsuarioEncontrado) 
	& (unUsuarioEncontrado isMemberOf: PublicUser)
	& (unUsuarioEncontrado noEsPropietarioDe: directorioActual))
	ifFalse:[self error: 'El usuario es root o no tiene permisos de escritura sobre este archivo/carpeta'].
	
	usuarioLogueado sacarPermisosParaEscribir: directorioActual para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:38:38'!
sacarPermisosDeEscrituraParaElArchivo: unArchivo alUsuario: unUsuario
	
	| listaDeArchivosEnElDirectorioActual unArchivoEncontrado unUsuarioEncontrado |
	listaDeArchivosEnElDirectorioActual _ directorioActual listaDeArchivos.
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo en: listaDeArchivosEnElDirectorioActual .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	((unArchivoEncontrado tienePermisosDeEscrituraDelUsuario: unUsuarioEncontrado) 
	& (unUsuarioEncontrado isMemberOf: PublicUser)
	& (unUsuarioEncontrado noEsPropietarioDe: unArchivoEncontrado))
	ifFalse:[self error: 'El usuario es root o no tiene permisos de escritura sobre este archivo/carpeta'].
	
	usuarioLogueado sacarPermisosParaEscribir: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:38:47'!
sacarPermisosDeLectura: unUsuario paraLaCarpeta: unaCarpeta
	
	| carpetaEncontrada unUsuarioEncontrado |
	carpetaEncontrada _ self obtenerCarpetaDelDirectorioActual: unaCarpeta.
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	((carpetaEncontrada tienePermisosDeLecturaDelUsuario: unUsuarioEncontrado) 
	& (unUsuarioEncontrado isMemberOf: PublicUser)
	& (unUsuarioEncontrado noEsPropietarioDe: carpetaEncontrada ))
	ifFalse:[self error: 'El usuario es root o no tiene permisos de lectura sobre este archivo/carpeta'].
	
	usuarioLogueado sacarPermisosParaLeer: carpetaEncontrada para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:38:56'!
sacarPermisosDeLecturaParaElArchivo: unArchivo alUsuario: unUsuario
	
	| listaDeArchivosEnElDirectorioActual unArchivoEncontrado unUsuarioEncontrado |
	listaDeArchivosEnElDirectorioActual _ directorioActual listaDeArchivos.
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo en: listaDeArchivosEnElDirectorioActual .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	((unArchivoEncontrado tienePermisosDeLecturaDelUsuario: unUsuarioEncontrado) 
	& (unUsuarioEncontrado isMemberOf: PublicUser)
	& (unUsuarioEncontrado noEsPropietarioDe: unArchivoEncontrado))
	ifFalse:[self error: 'El usuario es root o no tiene permisos de lectura sobre este archivo/carpeta'].
	
	usuarioLogueado sacarPermisosParaLeer: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:30:06'!
touch: unArchivo

	|listaDeArchivosEnElDirectorioActual|
	listaDeArchivosEnElDirectorioActual _ directorioActual listaDeArchivos.
	
	self elArchivo: unArchivo existeEnElDirectorioActual: listaDeArchivosEnElDirectorioActual .
	
	( (directorioActual tienePermisosDeEscrituraDelUsuario: usuarioLogueado) 
	| (self elDirectorioActualFueCreadoPorElUsuarioLogueadoOElUsuarioEsRoot) )
		ifFalse: [self error: 'El usuario no tiene permisos de escritura'].
	
	unArchivo creadoPor: usuarioLogueado.  
	listaDeArchivosEnElDirectorioActual add: unArchivo.! !


!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:17'!
cat: unArchivo 
	
	| listaDeArchivos  archivoDeLectura|
	listaDeArchivos _ directorioActual listaDeArchivos .
	archivoDeLectura _ self obtenerArchivo: unArchivo en: listaDeArchivos .
	
	( (archivoDeLectura tienePermisosDeLecturaDelUsuario: usuarioLogueado) 
	| (self elUsuarioLogueadoEsRootOCreoEl: archivoDeLectura))
		ifFalse: [self error: 'El usuario no tiene permisos de lectura'].
		
	^ archivoDeLectura texto.	 ! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:22'!
directorioActual
	
	^ directorioActual! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:26'!
errorContraseñaOUsuarioIncorrecto

	^ self error: 'El nombre y/o contraseña es incorrecta'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:29'!
errorLaCarpetaYaExiste

	^ self error: 'La carpeta ya existe en este directorio'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:32'!
errorUsuarioNoExistente

	^ self error: 'El usuario no existe'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:36'!
ls
	|listaDeArchivosYCarpetas|
	listaDeArchivosYCarpetas _ Set new.
	listaDeArchivosYCarpetas addAll: directorioActual listaDeArchivos.
	listaDeArchivosYCarpetas addAll: directorioActual listaDeCarpetas.
	^ listaDeArchivosYCarpetas.! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:43'!
obtenerArchivo: unArchivo en: listaDeArchivos

	^ listaDeArchivos detect: [:unArchivoEnLaLista | (unArchivoEnLaLista nombreEsIgual: unArchivo nombre)] 
		ifNone: [ self error: 'El archivo no existe']! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:30:52'!
obtenerCarpetaDelDirectorioActual: unaCarpeta

	| listaDeCarpetasEnElDirectorioActual |
	listaDeCarpetasEnElDirectorioActual _ directorioActual listaDeCarpetas.
	
	^ listaDeCarpetasEnElDirectorioActual detect: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista] 
		ifNone: [self error: 'La carpeta no existe en este directorio'.] .! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:31:14'!
obtenerUsuario: unUsuario

	^ listaDeUsuarios detect: [:unUsuarioEnLaLista | (unUsuarioEnLaLista nombreEsIgual: unUsuario nombre)] 
		ifNone: [ self errorUsuarioNoExistente ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Terminal class' category: 'Grupo1-TP-Final'!
Terminal class
	instanceVariableNames: ''!

!Terminal class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:20'!
iniciarSesion: unUser

	^self new initializeIniciarSesion: unUser ! !


!classDefinition: #User category: 'Grupo1-TP-Final'!
Object subclass: #User
	instanceVariableNames: 'nombre contraseña'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!User methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:32:59'!
contraseña

	^ contraseña! !

!User methodsFor: 'accessing' stamp: 'dk 11/25/2021 01:33:02'!
nombre

	^ nombre! !


!User methodsFor: 'testing' stamp: 'dk 11/25/2021 01:33:06'!
contraseñaEsIgual: unaContraseña 

	^ contraseña = unaContraseña ! !

!User methodsFor: 'testing' stamp: 'dk 11/25/2021 01:33:09'!
esIgualElUserYContraseñaA: unUser 

	^ (self nombreEsIgual: unUser nombre) & (self contraseñaEsIgual: unUser contraseña)! !

!User methodsFor: 'testing' stamp: 'dk 11/25/2021 01:33:56'!
noEsPropietarioDe: unArchivoOCarpeta

	^ unArchivoOCarpeta creadoPorUsuario nombre ~= nombre .! !

!User methodsFor: 'testing' stamp: 'dk 11/25/2021 01:33:18'!
nombreEsIgual: unNombre 

	^ nombre = unNombre ! !


!User methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:34:11'!
modificarPor: unUsuarioConModificaciones 
	
	nombre _ unUsuarioConModificaciones nombre .
	contraseña _ unUsuarioConModificaciones contraseña .! !


!classDefinition: #PublicUser category: 'Grupo1-TP-Final'!
User subclass: #PublicUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PublicUser methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:35:04'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre _ unNombre.
	contraseña _ unaContraseña.! !


!PublicUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 00:36:34'!
agregarPermisosParaEjecutar: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEjecutar: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 00:36:11'!
agregarPermisosParaEscribir: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEscribir: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 00:36:00'!
agregarPermisosParaLeer: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaLeer: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 00:36:43'!
sacarPermisosParaEjecutar: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEjecutar: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 00:36:50'!
sacarPermisosParaEscribir: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEscribir: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 00:36:56'!
sacarPermisosParaLeer: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaLeer: unUsuario .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublicUser class' category: 'Grupo1-TP-Final'!
PublicUser class
	instanceVariableNames: ''!

!PublicUser class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:15'!
conNombre: unNombre yContraseña: unaContraseña

	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !


!classDefinition: #RootUser category: 'Grupo1-TP-Final'!
User subclass: #RootUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!RootUser methodsFor: 'initialization' stamp: 'dk 11/25/2021 01:34:57'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre _ unNombre.
	contraseña _ unaContraseña.! !


!RootUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:34:28'!
agregarPermisosParaEjecutar: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEjecutar: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:34:32'!
agregarPermisosParaEscribir: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEscribir: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:34:35'!
agregarPermisosParaLeer: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaLeer: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:34:39'!
borrarUsuario: unUser en: unaTerminal

	unaTerminal borrarUsuario: unUser .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:34:42'!
modificarUsuario: unUsuario por: unUsuarioConModificaciones en: unaTerminal
 
	unaTerminal modificarUsuario: unUsuario por: unUsuarioConModificaciones .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/25/2021 01:34:45'!
registrarUsuario: unUser en: unaTerminal

	unaTerminal ingresarUsuario: unUser .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:44:52'!
sacarPermisosParaEjecutar: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEjecutar: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:34:31'!
sacarPermisosParaEscribir: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEscribir: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/24/2021 00:44:43'!
sacarPermisosParaLeer: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaLeer: unUsuario .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootUser class' category: 'Grupo1-TP-Final'!
RootUser class
	instanceVariableNames: ''!

!RootUser class methodsFor: 'instance creation' stamp: 'dk 11/25/2021 01:39:10'!
conNombre: unNombre yContraseña: unaContraseña 

	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !
