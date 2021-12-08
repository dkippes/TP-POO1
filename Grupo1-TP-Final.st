!classDefinition: #FileTest category: 'Grupo1-TP-Final'!
TestCase subclass: #FileTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FileTest methodsFor: 'file_testing' stamp: 'dk 12/7/2021 16:10:25'!
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

!FileTest methodsFor: 'file_testing' stamp: 'dk 12/7/2021 16:10:31'!
test002_cuandoUnArchivoSeCrea_EsteTieneNombre_UnaFechaDeCreacionYUnaFechaDeModificacion
	
	"Setup"
	| unArchivoNuevo unaFechaDeCreacion |
	
	unArchivoNuevo _ TextFile conNombre: 'Archivo1.txt'.
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

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 12/7/2021 16:12:20'!
unaTerminalConUnUsuarioPublicoLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	unaTerminal iniciarSesion: unUserPublicDiego4321.
	
	^ unaTerminal .! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 12/7/2021 16:12:23'!
unaTerminalConUnUsuarioRootDefaultLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	^ unaTerminal .! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 12/7/2021 16:12:28'!
unaTerminalRootConArchivos

	| unaTerminal unArchivoDeTexto unArchivoDeTexto2 |
	
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoDeTexto _ archivoDeTexto .
	unArchivoDeTexto2 _ archivoDeTexto2 .
	
	unaTerminal touch: unArchivoDeTexto .
	unaTerminal touch: unArchivoDeTexto2 .
	unaTerminal nano: unArchivoDeTexto2 edicion: 'Texto Modificado'.
	
	^ unaTerminal ! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 12/7/2021 16:12:34'!
unaTerminalRootConArchivosYCarpetas

	| unaTerminal |
	
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	unaTerminal touch: archivoDeTexto2 .
	unaTerminal nano: archivoDeTexto2 edicion: 'Texto Modificado'.
	unaTerminal mkdir: 	carpetaTomas .
	
	^ unaTerminal ! !


!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:12:40'!
test001_cuandoUnaTerminalSeCrea_iniciaSesionUnUsuarioRoot

	"Setup"
	| terminal unUsuarioRoot |
	unUsuarioRoot _ RootUser conNombre: 'root' yContraseña: 'root' .
	terminal _ Terminal iniciarSesion: unUsuarioRoot .
	
	Assert isTrue: (terminal tieneAlUsuarioLogueado: unUsuarioRoot) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:12:46'!
test002_cuandoUnaTerminalSeCrea_unUsuarioRoot_registraUnUsuario_esteIniciaSesion

	"Setup"
	| unUsuarioLogueado unaTerminal |
	unUsuarioLogueado _ PublicUser conNombre: 'Diego' yContraseña: '1234' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioLogueado en: unaTerminal .
	unaTerminal iniciarSesion: unUsuarioLogueado .
	
	Assert isTrue: (unaTerminal tieneAlUsuarioLogueado: unUsuarioLogueado) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:49:25'!
test003_cuandoUnaTerminalSeCrea_unUsuarioTrataDeLoguearseInsactifactoriamente

	"Setup & Exercise"
	| unUserInexistente |
	unUserInexistente _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserInexistente]
        signal: Error
        withDescription: Terminal errorUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:49:21'!
test004_cuandoUnaTerminalSeCrea_unUsuarioRootTrataDeLoguearseInsactifactoriamente

	"Setup"
	| unUserRootInexistente |
	unUserRootInexistente _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserRootInexistente ]
        signal: Error
        withDescription: Terminal errorUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:13:00'!
test005_cuandoUnaTerminalSeCrea_unUsuarioRoot_registraUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isTrue: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:13:05'!
test006_cuandoUnaTerminalSeCrea_unUsuarioRoot_borraUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ unUserPublicDiego4321 .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	unUserRootDefault borrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isFalse: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:49:13'!
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
        withDescription: Terminal errorUsuarioIncorrecto.
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:48:48'!
test008_cuandoUnaTerminalSeCrea_unUsuarioRoot_trataDeBorraUnUsuarioInexistente

	"Setup"
	| terminal |
	terminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	Assert
        should: [ unUserRootDefault borrarUsuario: unUserPublicDiego4321 en: terminal  ]
        signal: Error
        withDescription: Terminal errorUsuarioInexistente .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:13:32'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:48:33'!
test010_cuandoUnaTerminalSeCrea_unUsuarioRoot_noPuedeModificarUsuarioInexistente

	"Setup"
	| unaTerminal unUsuarioAAgregar unUsuarioModificado |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unUsuarioModificado _ PublicUser conNombre: 'Tomaz' yContraseña: '9876' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	Assert
        should: [ unUserRootDefault modificarUsuario: unUsuarioAAgregar por: unUsuarioModificado en: unaTerminal ]        
	 signal: Error
        withDescription: Terminal errorUsuarioInexistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:15:58'!
test011_cuandoUnUsuarioIniciaSesion_esteEstaParadoEnLaCarpetaRoot

	"Setup"
	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
		
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:14:03'!
test012_cuandoUnUsuarioEscribeMkDirEnLaTerminal_creaUnaCarpetaEnElDirectorio

	"Setup"
	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Exersice" 
	unaTerminal mkdir: carpetaTomas .

	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert isTrue: (unaTerminal tieneCarpetasEnElDirectorioActual).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:14:09'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:48:07'!
test014_cuandoUnUsuarioEscribeCDEnLaTerminal_noPuedeIngresarAUnaCarpetaInexistente

	| unaTerminal unaCarpeta |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpeta _ carpetaTomas .

	"Assert"
	Assert
        should: [unaTerminal cd: unaCarpeta .]
        signal: Error
        withDescription: Terminal errorLaCarpetaNoExiste .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:16:18'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:47:41'!
test016_cuandoUnUsuarioEscribeCDParaVolverEnLaTerminal_esteNoPuedeRegresarALaCarpetaAnterior_porEstarEnElDirectorioRoot

	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cd .]
        signal: Error
        withDescription: Terminal errorNoSePuedeVolver .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:16:33'!
test017_cuandoUnUsuarioIngresaAUnaCarpetas_esteLuegoRegresaARoot

	| unaTerminal unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ carpetaTomas .

	"Exercise"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
	unaTerminal cd .
	
	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:47:13'!
test018_cuandoUnUsuarioIngresaAVariasCarpetas_esteSePosicionaEnRoot

	| unaTerminal unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ carpetaTomas .

	"Exercise"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
	unaTerminal cd . 
	
	"Assert"
	Assert
        should: [unaTerminal cd .]
        signal: Error
        withDescription: Terminal errorNoSePuedeVolver .
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:16:51'!
test019_cuandoUnUsuarioEscribeElComandoTouch_esteCreaUnArchivo

	| unaTerminal unArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoNuevo _ TextFile conNombre: 'Archivo1.txt' .
	
	"Exercise"
	unaTerminal touch: unArchivoNuevo.
	
	"Assert"
	Assert isTrue: (unaTerminal tieneElArchivoEnElDirectorioActual: unArchivoNuevo).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:46:43'!
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
        withDescription: Terminal errorNoSePuedeCrearUnArchivoConElMismoNombre .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:17:05'!
test021_cuandoUnUsuarioListaElContenidoDelDirectorio_conElComandoLS_esteListaTodosLosArchivosYLasCarpetas

	| unaTerminal listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivosYCarpetas .
	listaDeArchivosYCarpetas _ OrderedCollection new.
	listaDeArchivosYCarpetas add: archivoDeTexto2 .
	listaDeArchivosYCarpetas add: carpetaTomas .
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:17:09'!
test022_cuandoUnUsuarioListaElContenidoDelDirectorio_conElComandoLS_noTieneNadaEnElDirectorioActual

	| unaTerminal listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	listaDeArchivosYCarpetas _ OrderedCollection new.

	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:46:27'!
test023_cuandoUnUsuarioBorraUnArchivo_conElComandoRM_esteSeBorraDelDirectorioActual

	| unaTerminal unaArchivoNuevo listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ archivoDeTexto .
	listaDeArchivosYCarpetas _ OrderedCollection new.
	
	"Exercise"
	unaTerminal touch: unaArchivoNuevo.
	unaTerminal rmArchivo: unaArchivoNuevo.

	"Assert"
	Assert that: unaTerminal ls isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:17:34'!
test024_cuandoUnUsuarioRootLeaUnArchivoDeText_esteMuestraElTexto

	| unaTerminal unaArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ archivoDeTexto .
	
	"Exercise"
	unaTerminal touch: unaArchivoNuevo .
	
	"Assert"
	Assert that: (unaTerminal cat: unaArchivoNuevo)  isEqualTo: ''.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:46:20'!
test025_cuandoUnUsuarioRootLeaUnArchivoDeText_esteNoExisteEnElDirectorioActual

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cat: archivoDeTexto]
        signal: Error
        withDescription: Terminal errorElArchivoNoExiste .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:17:45'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:45:55'!
test027_cuandoUnUsuarioRootModifiqueUnArchivoDeTexto_esteNoExiste

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Assert"
	Assert
        should: [unaTerminal nano: archivoDeTexto edicion: 'Texto Modificado']
        signal: Error
        withDescription: Terminal errorElArchivoNoExiste .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:17:54'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:29'!
test029_cuandoUnUsuarioFiltreUnArchivoPorTextoDado_esteNoEncuentraResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeTexto |
	
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	unFiltroDeTexto _ FilterText conElTexto: 'Texto no encontrado' .
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDeTexto } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:18:23'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:18:31'!
test031_cuandoUnUsuarioCreaUnArchivo_EsteLePertenece 
	
	"Setup"
	|unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
		
	"Assert"
	Assert that: archivoDeTexto creadoPorUsuario isEqualTo: unUserRootDefault .
	Assert isTrue:(archivoDeTexto fueCreadoPor: unUserRootDefault ).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:18:58'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:29'!
test033_cuandoUnUsuarioFiltreUnArchivoPorUnUsuarioDado_esteEncuentraResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeUsuario |
	
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	listaDeArchivosEncontrados add: archivoDeTexto.
	listaDeArchivosEncontrados add: archivoDeTexto2.
	unFiltroDeUsuario _ FilterUser conElUsuario: unUserRootDefault.
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDeUsuario } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:29'!
test034_cuandoUnUsuarioFiltreUnArchivoPorUnUsuarioDado_esteEncuentraNoResultados

	| unaTerminal listaDeArchivosEncontrados unFiltro unFiltroDeUsuario |
	"Setup"
	unaTerminal _ self unaTerminalRootConArchivos .
	listaDeArchivosEncontrados _ Set new .
	unFiltroDeUsuario _ FilterUser conElUsuario: unUserRootDiego4321.
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDeUsuario } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:45:42'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeLectura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:19:29'!
test036_cuandoUnUsuarioRootLeeUnArchivoDeTexto_EsteTienePermisosDeLectura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	
	"Assert"
	Assert that: (unaTerminal cat: archivoDeTexto) isEqualTo: '' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:19:35'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:45:30'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:19:47'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:19:54'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:45:19'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeEjecucion.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:20:13'!
test042_cuandoUnUsuarioRootEjecuteUnArchivoDeTexto_esteTienePermisosDeEjecucion

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ejecutar: archivoDeTexto) isEqualTo: archivoDeTexto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:20:22'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:44:58'!
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
        should: [unaTerminal rmArchivo: archivoDeTexto]
        signal: Error
        withDescription: Terminal errorUsuarioSinPermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:46:28'!
test045_cuandoUnUsuarioRootRemuevaUnArchivoDeTexto_esteTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal touch: archivoDeTexto.
	unaTerminal rmArchivo: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: OrderedCollection new .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:46:27'!
test046_cuandoUnUsuarioPropietarioRemuevaUnArchivoDeTexto_esteTienePermisosDeEscritura

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserRootDiego1234 .
	unaTerminal iniciarSesion: unUserRootDiego1234 .
	unaTerminal touch: archivoDeTexto.
	unaTerminal rmArchivo: archivoDeTexto .
	
	"Assert"
	Assert that: (unaTerminal ls) isEqualTo: OrderedCollection new .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:44:43'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:44:17'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:21:55'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:43:44'!
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
        withDescription: Terminal errorUsuarioYaTienePermisosDeLectura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:22:13'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:43:32'!
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
        withDescription: Terminal errorUsuarioYaTienePermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:22:30'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:43:19'!
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
        withDescription: Terminal errorUsuarioYaTienePermisosDeEjecucion.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:42:16'!
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
        withDescription: Terminal errorElUsuarioNoPuedeBorrarse .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:22:57'!
test056_cuandoUnUsuarioRootLeAgregaUnPermisoDeEscrituraAUnUsuario_estePuedeEscribirEnLaCarpeta

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321. 
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	unaTerminal mkdir: 	carpetaTomas .
	
	"Assert"
	Assert isTrue: unaTerminal esDirectoRaiz.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:41:12'!
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
        withDescription: Terminal errorUsuarioYaTienePermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:23:19'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:40:25'!
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
        withDescription: Terminal errorUsuarioYaTienePermisosDeLectura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:51'!
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
	unFiltroDePermiso _ FilterWritePermission conElUsuario: (unUserPublicDiego4321). 
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:51'!
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
	unFiltroDePermiso _ FilterWritePermission conElUsuario: (unUserRootDiego1234). 
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:46'!
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
	unFiltroDePermiso _ FilterReadPermission conElUsuario: (unUserPublicDiego4321).
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:51'!
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
	unFiltroDePermiso _ FilterWritePermission conElUsuario: (unUserRootDiego1234). 
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDePermiso } .
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:29'!
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
	unFiltroDePermiso _ FilterExecutePermission conElUsuario: (unUserPublicDiego4321).
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDePermiso } .	
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:24:29'!
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
	unFiltroDePermiso _ FilterExecutePermission conElUsuario: (unUserRootDiego1234). 
	unFiltro _ CompositeFilter filtrarPor: { unFiltroDePermiso }.
	
	"Exercise & Assert"
	Assert that: (unaTerminal filtrarCon: unFiltro) isEqualTo: listaDeArchivosEncontrados .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:39:54'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:39:40'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeLectura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:39:11'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeEjecucion.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:38:56'!
test069_cuandoSeLeSacaPermisosDeEscrituraAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermiso

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeEscrituraParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .]
        signal: Error
        withDescription: Terminal errorUsuarioNoTienePermisosDeEscritura .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:38:34'!
test070_cuandoSeLeSacaPermisosDeLecturaAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermiso

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeLecturaParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .]
        signal: Error
        withDescription: Terminal errorUsuarioNoTienePermisosDeLectura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:38:02'!
test071_cuandoSeLeSacaPermisosDeEjecucionAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermiso

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeEjecutarParaElArchivo: archivoDeTexto alUsuario: unUserPublicDiego4321 .]
        signal: Error
        withDescription: Terminal errorUsuarioNoTienePermisosDeEjecucion .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:37:10'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeLectura .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:36:44'!
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
        withDescription: Terminal errorUsuarioSinPermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:35:57'!
test074_cuandoSeLeSacaPermisosDeLecturaAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermisoALaCarpeta

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal mkdir: carpetaDiego .
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeLectura: unUserPublicDiego4321 paraLaCarpeta: carpetaDiego .]
        signal: Error
        withDescription: Terminal errorUsuarioNoTienePermisosDeLectura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:35:19'!
test075_cuandoSeLeSacaPermisosDeEscrituraAUnUsuario_yaNoPodriaSacarleNuevamenteElMismoPermisoALaCarpeta

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	
	Assert
        should: [unaTerminal sacarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .]
        signal: Error
        withDescription: Terminal errorUsuarioNoTienePermisosDeEscritura.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:26:12'!
test076_cuandoUnUsuarioIniciaSesion_esteSiempreEmpiezaEnLaCarpetaRoot

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaTerminal mkdir: carpetaTomas .
	unaTerminal cd: carpetaTomas .
	unaTerminal ingresarUsuario: unUserPublicDiego4321 .
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	Assert isTrue: unaTerminal estaParadaEnElDirectorioRaiz .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:26:19'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:34:34'!
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
        withDescription: Terminal errorUsuarioYaTienePermisosDeEjecucion.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:26:41'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:26:48'!
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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:33:59'!
test081_cuandoUnUsuarioRoot_quieraAgregarPermisosAUnUsuarioInexistente_esteNoPuede

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	Assert
        should: [unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321 .]
        signal: Error
        withDescription: Terminal errorUsuarioInexistente.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:26:58'!
test082_cuandoNoHayArchivosOCarpetasEnElDirectorioActual_NoHayTextoEscritoHastaElMomento

	| unaTerminal textoEsperado|
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	textoEsperado _ 'root:', String newLineString .

	Assert that: unaTerminal textoEscritoHastaElMomento isEqualTo: textoEsperado.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:27:06'!
test083_cuandoHayArchivosOCarpetasEnElDirectorioActual_HayTextoEscritoHastaElMomento

	| unaTerminal textoEsperado |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	textoEsperado _ 
	'root:', String newLineString, 
	'Archivo1.txt', String tab, 'lectura[]', String tab, 'escritura[]', String tab, 'ejecucion[]', String newLineString, 
	'Diego', String tab, 'lectura[]', String tab, 'escritura[]', String newLineString.
	
	unaTerminal mkdir: carpetaDiego.
	unaTerminal touch: archivoDeTexto.

	Assert that: unaTerminal textoEscritoHastaElMomento isEqualTo: textoEsperado.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:27:12'!
test084_seCreaUnArchivoDeTextoVacio_cuandoNoHayArchivosOCarpetas

	| unaTerminal textoEsperado|
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	textoEsperado _ 'root:', String newLineString. 

	unaTerminal imprimirInfoDelDirectorio.
	
	Assert that: unaTerminal textoEscritoHastaElMomento isEqualTo: textoEsperado.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:27:21'!
test085_seCreaUnArchivoDeTextoConInfoDePermisos_cuandoHayCarpetas

	| unaTerminal textoEsperado|
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	textoEsperado _ 'root:', String newLineString, 
	'Diego', String tab, 'lectura[Tomas,]', String tab, 'escritura[Tomas,]', String newLineString.
	
	unaTerminal mkdir: carpetaDiego.
	unaTerminal ingresarUsuario: unUserPublicTomas4321. 
	unaTerminal agregarPermisosDeLectura: unUserPublicTomas4321 paraLaCarpeta: carpetaDiego. 
	unaTerminal cd: carpetaDiego.
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicTomas4321.
	unaTerminal cd.
	unaTerminal imprimirInfoDelDirectorio.
	
	Assert that: unaTerminal textoEscritoHastaElMomento isEqualTo: textoEsperado.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 16:27:25'!
test086_seCreaUnArchivoDeTextoConInfoDePermisos_cuandoHayArchivos

	| unaTerminal textoEsperado|
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	textoEsperado _ 'Tomas:', String newLineString, 
	'Archivo1.txt', String tab, 'lectura[Tomas,]', String tab, 'escritura[Tomas,]', String tab, 'ejecucion[Tomas,]', String newLineString.
	
	unaTerminal mkdir: carpetaTomas .
	unaTerminal cd: carpetaTomas .
	unaTerminal touch: archivoDeTexto.
	unaTerminal ingresarUsuario: unUserPublicTomas4321. 
	unaTerminal agregarPermisosDeLectura: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	unaTerminal agregarPermisosDeEscritura: unUserPublicTomas4321 enElArchivo: archivoDeTexto .
	unaTerminal agregarPermisosDeEjecucion: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	unaTerminal imprimirInfoDelDirectorio.
	
	Assert that: unaTerminal textoEscritoHastaElMomento isEqualTo: textoEsperado.
	Assert isTrue: carpetaTomas tieneArchivos .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:32:37'!
test087_cuandoSeCreaUnaCarpetaEnElDirectorio_estaYaExiste

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	unaTerminal mkdir: carpetaTomas .

	Assert
        should: [unaTerminal mkdir: carpetaTomas]
        signal: Error
        withDescription: Terminal errorLaCarpetaYaExiste.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 17:46:47'!
test088_cuandoSeEliminaUnaCarpeta_estaDejaDeExistir

	| unaTerminal carpetasEnElDirectorioActual |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	carpetasEnElDirectorioActual _ OrderedCollection new.
	unaTerminal mkdir: carpetaTomas .
	unaTerminal rmCarpeta: carpetaTomas .
	
	Assert that: unaTerminal ls isEqualTo: carpetasEnElDirectorioActual .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:32:11'!
test089_cuandoSeEliminaUnaCarpeta_estaDejaNoExistiaConAnterioridadEnElDirectorio

	| unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.	
	
	Assert
        should: [unaTerminal rmCarpeta: carpetaTomas .]
        signal: Error
        withDescription: Terminal errorCarpetaInexistente.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:12:56'!
test090_cuandoUnUsuarioOwnerLeAgregaUnPermisoDeLecturaEscrituraYEjecucionAUnUsuario_estePuedeLeerElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal ingresarUsuario: unUserPublicTomas4321 .
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeLectura: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	unaTerminal agregarPermisosDeEscritura: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	unaTerminal agregarPermisosDeEjecucion: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	unaTerminal iniciarSesion: unUserPublicTomas4321 .
	
	"Assert"
	Assert that: (unaTerminal cat: archivoDeTexto) isEqualTo: ''.
	Assert that: (unaTerminal ejecutar: archivoDeTexto) isEqualTo: archivoDeTexto.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 12/7/2021 18:31:22'!
test091_cuandoUnUsuarioOwnerLeSacaUnPermisoDeLecturaEscrituraYEjecucionAUnUsuario_esteNoPuedeLeerEscribirNiEjecutarElArchivo

	|unaTerminal |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	
	"Exercise"
	unaTerminal ingresarUsuario: unUserPublicDiego4321.
	unaTerminal ingresarUsuario: unUserPublicTomas4321 .
	unaTerminal agregarPermisosDeEscrituraEnElDirectorioPara: unUserPublicDiego4321.
	unaTerminal iniciarSesion: unUserPublicDiego4321 .
	
	unaTerminal touch: archivoDeTexto.
	unaTerminal agregarPermisosDeLectura: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	unaTerminal agregarPermisosDeEscritura: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	unaTerminal agregarPermisosDeEjecucion: unUserPublicTomas4321 enElArchivo: archivoDeTexto.
	
	unaTerminal sacarPermisosDeLecturaParaElArchivo: archivoDeTexto alUsuario: unUserPublicTomas4321.
	unaTerminal sacarPermisosDeEscrituraParaElArchivo: archivoDeTexto alUsuario: unUserPublicTomas4321.
	unaTerminal sacarPermisosDeEjecutarParaElArchivo: archivoDeTexto alUsuario: unUserPublicTomas4321.
	unaTerminal iniciarSesion: unUserPublicTomas4321 .
	
	"Assert"
	Assert
        should: [unaTerminal cat: archivoDeTexto .]
        signal: Error
        withDescription: Terminal errorUsuarioSinPermisosDeLectura.
	Assert
        should: [unaTerminal ejecutar: archivoDeTexto]
        signal: Error
        withDescription: Terminal errorUsuarioSinPermisosDeEjecucion.! !


!TerminalTest methodsFor: 'setUp/tearDown' stamp: 'dk 12/7/2021 17:24:29'!
setUp

	unUserRootDefault _ RootUser conNombre: 'root' yContraseña: 'root' .
	unUserRootDiego1234 _ RootUser conNombre: 'Diego' yContraseña: '1234' .
	unUserRootDiego4321 _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	unUserPublicDiego4321 _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unUserPublicTomas4321 _ PublicUser conNombre: 'Tomas' yContraseña: '4321' .
	
	carpetaTomas _ Folder	 conNombre: 'Tomas' .
	carpetaDiego _ Folder	 conNombre: 'Diego' .
	
	archivoDeTexto _ TextFile conNombre: 'Archivo1.txt' .
	archivoDeTexto2 _ TextFile conNombre: 'Archivo2.txt' .
	
	filtroDeTexto _ FilterText conElTexto: 'Texto Modificado' .
	filtroDeFecha _ FilterCreationFile conLaFecha: FixedGregorianDate today .
	
	filtroCompuestoPorTexto _ CompositeFilter filtrarPor: { filtroDeTexto } .
	filtroCompuestoPorFecha _ CompositeFilter filtrarPor: { filtroDeFecha } .
	filtroCompuestoPorTextoYFecha _ CompositeFilter filtrarPor: { filtroDeTexto . filtroDeFecha } .! !


!classDefinition: #File category: 'Grupo1-TP-Final'!
Object subclass: #File
	instanceVariableNames: 'nombre fechaDeCreacion fechaDeModificacion creadoPorUsuario permisosDeLectura permisosDeEscritura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!File methodsFor: 'subclass message' stamp: 'dk 12/7/2021 15:53:06'!
creadoPor: unUsuario 

	self subclassResponsibility.! !

!File methodsFor: 'subclass message' stamp: 'dk 12/7/2021 15:53:12'!
tienePermisoDeLecturaDelUsuario: unUsuario 

	self subclassResponsibility.! !

!File methodsFor: 'subclass message' stamp: 'dk 12/7/2021 15:53:17'!
tienePermisosDeEscrituraDelUsuario: unUsuario 

	self subclassResponsibility.! !


!File methodsFor: 'accessing' stamp: 'dk 12/7/2021 15:53:22'!
creadoPorUsuario

	^ creadoPorUsuario.! !

!File methodsFor: 'accessing' stamp: 'dk 12/7/2021 16:11:27'!
fechaDeCreacion

	^ fechaDeCreacion! !

!File methodsFor: 'accessing' stamp: 'dk 12/7/2021 15:53:27'!
fechaDeModificacion

	^ fechaDeModificacion! !

!File methodsFor: 'accessing' stamp: 'dk 12/7/2021 15:53:44'!
nombre

	^ nombre! !


!File methodsFor: 'testing' stamp: 'dk 12/7/2021 18:23:12'!
esCreadoPor: unUsuario

	^ creadoPorUsuario = (unUsuario nombre) .! !

!File methodsFor: 'testing' stamp: 'dk 12/7/2021 15:53:33'!
nombreEsIgual: unNombre

	^ nombre = unNombre.! !


!File methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:52:48'!
agregarPermisosParaEscribir: unUsuario 

	permisosDeEscritura agregar: unUsuario.! !

!File methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:52:51'!
agregarPermisosParaLeer: unUsuario 
	
	permisosDeLectura agregar: unUsuario.! !

!File methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:52:54'!
sacarPermisosParaEscribir: unUsuario 
	
	permisosDeEscritura sacar: unUsuario ! !

!File methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:52:56'!
sacarPermisosParaLeer: unUsuario 
	
	permisosDeLectura sacar: unUsuario ! !


!classDefinition: #Folder category: 'Grupo1-TP-Final'!
File subclass: #Folder
	instanceVariableNames: 'carpetas archivos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Folder methodsFor: 'initialization' stamp: 'dk 12/7/2021 15:54:54'!
inicializarConNombre: unNombre

	nombre _ unNombre.! !

!Folder methodsFor: 'initialization' stamp: 'dk 12/7/2021 17:25:43'!
initialize

	carpetas _ Set new.
	archivos _ Set new. 
	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.
	
	permisosDeLectura _ ReadPermission new.
	permisosDeEscritura _ WritePermission new.! !


!Folder methodsFor: 'accessing' stamp: 'dk 12/7/2021 15:54:01'!
archivos

	^ archivos! !

!Folder methodsFor: 'accessing' stamp: 'dk 12/7/2021 15:54:47'!
carpetas

	^ carpetas! !


!Folder methodsFor: 'testing' stamp: 'dk 12/7/2021 15:54:07'!
tieneArchivos

	^ archivos notEmpty.! !

!Folder methodsFor: 'testing' stamp: 'dk 12/7/2021 15:54:09'!
tieneCarpetas

	^ carpetas notEmpty.! !

!Folder methodsFor: 'testing' stamp: 'dk 12/7/2021 15:54:12'!
tienePermisosDeEscrituraDelUsuario: unUsuario 

	^ (permisosDeEscritura tienePermisos: unUsuario)! !

!Folder methodsFor: 'testing' stamp: 'dk 12/7/2021 15:54:14'!
tienePermisosDeLecturaDelUsuario: unUsuario 
	
	^ (permisosDeLectura tienePermisos: unUsuario)! !


!Folder methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:53:51'!
agregarCarpeta: unaCarpeta 

	carpetas add: unaCarpeta.! !

!Folder methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:53:54'!
creadoPor: unUsuario

	creadoPorUsuario _ unUsuario! !


!Folder methodsFor: 'printing' stamp: 'dk 12/7/2021 15:55:06'!
printOn: unStream
   
	unStream nextPutAll: nombre, String tab.
	unStream nextPutAll: 'lectura['.
	permisosDeLectura printOn: unStream.
	unStream nextPutAll: ']', String tab.
	unStream nextPutAll: 'escritura['.
	permisosDeEscritura printOn: unStream.
	unStream nextPutAll: ']'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Folder class' category: 'Grupo1-TP-Final'!
Folder class
	instanceVariableNames: ''!

!Folder class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:54:17'!
conNombre: unNombre

	^ self new inicializarConNombre: unNombre.! !


!classDefinition: #TextFile category: 'Grupo1-TP-Final'!
File subclass: #TextFile
	instanceVariableNames: 'texto permisosDeEjecucion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!TextFile methodsFor: 'initialization' stamp: 'dk 12/7/2021 17:26:01'!
initialize

	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.

	texto _ '' .
	permisosDeLectura _ ReadPermission new.
	permisosDeEscritura _ WritePermission new.
	permisosDeEjecucion _ ExecutePermission new.! !

!TextFile methodsFor: 'initialization' stamp: 'dk 12/7/2021 15:55:24'!
initializeConNombre: unNombre 

	nombre _ unNombre.! !


!TextFile methodsFor: 'accessing' stamp: 'dk 12/7/2021 16:10:54'!
texto

	^ texto! !


!TextFile methodsFor: 'testing' stamp: 'dk 12/7/2021 16:10:58'!
fueCreadoPor: unUsuario 

	^ (creadoPorUsuario nombre = unUsuario nombre).! !

!TextFile methodsFor: 'testing' stamp: 'dk 12/7/2021 16:11:00'!
tienePermisosDeEjecucionDelUsuario: unUsuario 

	^ (permisosDeEjecucion tienePermisos: unUsuario) | (unUsuario esRoot) ! !

!TextFile methodsFor: 'testing' stamp: 'dk 12/7/2021 16:11:02'!
tienePermisosDeEscrituraDelUsuario: unUsuario 

	^ (permisosDeEscritura tienePermisos: unUsuario) | (unUsuario esRoot)! !

!TextFile methodsFor: 'testing' stamp: 'dk 12/7/2021 16:11:04'!
tienePermisosDeLecturaDelUsuario: unUsuario

	^(permisosDeLectura tienePermisos: unUsuario) | (unUsuario esRoot)! !


!TextFile methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:10:36'!
agregarPermisosParaEjecutar: unUsuario 
	
	permisosDeEjecucion agregar: unUsuario.! !

!TextFile methodsFor: 'public actions' stamp: 'dk 12/7/2021 23:25:47'!
creadoPor: unUsuario

	creadoPorUsuario _ unUsuario.
	
	(unUsuario esPublico) 
	ifTrue:[ 
		permisosDeEjecucion agregar: unUsuario.
		permisosDeEscritura agregar: unUsuario.
		permisosDeLectura agregar: unUsuario.
	].
! !

!TextFile methodsFor: 'public actions' stamp: 'dk 12/7/2021 18:16:34'!
modificarTexto: unTexto 

	texto _ unTexto .
	fechaDeModificacion _ FixedGregorianDate today .! !

!TextFile methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:10:46'!
sacarPermisosParaEjecutar: unUsuario 
	
	permisosDeEjecucion sacar: unUsuario ! !


!TextFile methodsFor: 'printing' stamp: 'dk 12/7/2021 23:26:58'!
printOn: unStream
   
	unStream nextPutAll: nombre, String tab.
	unStream nextPutAll: 'lectura['.
	permisosDeLectura printOn: unStream.
	unStream nextPutAll: ']', String tab.
	unStream nextPutAll: 'escritura['.
	permisosDeEscritura printOn: unStream.
	unStream nextPutAll: ']', String tab.
	unStream nextPutAll: 'ejecucion['.
	permisosDeEjecucion printOn: unStream.
	unStream nextPutAll: ']'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TextFile class' category: 'Grupo1-TP-Final'!
TextFile class
	instanceVariableNames: ''!

!TextFile class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:54:23'!
conNombre: unNombre

	^ self new initializeConNombre: unNombre. ! !


!classDefinition: #Filter category: 'Grupo1-TP-Final'!
Object subclass: #Filter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Filter methodsFor: 'sub class message' stamp: 'dk 12/7/2021 18:55:46'!
puedeFiltrar: unArchivo

	self subclassResponsibility .! !


!classDefinition: #CompositeFilter category: 'Grupo1-TP-Final'!
Filter subclass: #CompositeFilter
	instanceVariableNames: 'listaDeFiltros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!CompositeFilter methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:04:25'!
initializeFiltrarPor: unaListaDeFiltros 

	listaDeFiltros _ unaListaDeFiltros.! !


!CompositeFilter methodsFor: 'accessing' stamp: 'dk 12/7/2021 16:04:28'!
filtrarArchivosEnElDirectorio: unaColeccionDeArchivos

	^ unaColeccionDeArchivos select: [: unArchivo| listaDeFiltros allSatisfy:[: unFiltro| unFiltro puedeFiltrar: unArchivo] ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompositeFilter class' category: 'Grupo1-TP-Final'!
CompositeFilter class
	instanceVariableNames: ''!

!CompositeFilter class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:54:30'!
filtrarPor: unaListaDeFiltros
	
	^ self new initializeFiltrarPor: unaListaDeFiltros. ! !


!classDefinition: #FilterCreationFile category: 'Grupo1-TP-Final'!
Filter subclass: #FilterCreationFile
	instanceVariableNames: 'fechaDeCreacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterCreationFile methodsFor: 'initialization' stamp: 'dk 12/7/2021 15:59:05'!
initializeConLaFecha: unaFechaDeCreacion 

	fechaDeCreacion _ unaFechaDeCreacion.! !


!FilterCreationFile methodsFor: 'testing' stamp: 'dk 12/7/2021 15:59:20'!
puedeFiltrar: unArchivo

	^ (fechaDeCreacion = unArchivo fechaDeCreacion).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterCreationFile class' category: 'Grupo1-TP-Final'!
FilterCreationFile class
	instanceVariableNames: ''!

!FilterCreationFile class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:54:36'!
conLaFecha: unaFechaDeCreacion

	^ self new initializeConLaFecha: unaFechaDeCreacion. ! !


!classDefinition: #FilterPermisson category: 'Grupo1-TP-Final'!
Filter subclass: #FilterPermisson
	instanceVariableNames: 'usuarioAFiltrar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterPermisson methodsFor: 'sub class message' stamp: 'dk 12/7/2021 18:50:48'!
puedeFiltrar: unArchivo

	self subclassResponsibility .! !


!FilterPermisson methodsFor: 'initialization' stamp: 'dk 12/7/2021 18:53:48'!
initializeConElUsuario: unUsuario 

	usuarioAFiltrar _ unUsuario.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterPermisson class' category: 'Grupo1-TP-Final'!
FilterPermisson class
	instanceVariableNames: ''!

!FilterPermisson class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:51:43'!
conElUsuario: unUsuario 

	^self new initializeConElUsuario: unUsuario. ! !


!classDefinition: #FilterExecutePermission category: 'Grupo1-TP-Final'!
FilterPermisson subclass: #FilterExecutePermission
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterExecutePermission methodsFor: 'testing' stamp: 'dk 12/7/2021 18:53:52'!
puedeFiltrar: unArchivo 

	 ^ (unArchivo tienePermisosDeEjecucionDelUsuario: usuarioAFiltrar).! !


!classDefinition: #FilterReadPermission category: 'Grupo1-TP-Final'!
FilterPermisson subclass: #FilterReadPermission
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterReadPermission methodsFor: 'testing' stamp: 'dk 12/7/2021 18:53:55'!
puedeFiltrar: unArchivo

	^ (unArchivo tienePermisosDeLecturaDelUsuario: usuarioAFiltrar).! !


!classDefinition: #FilterWritePermission category: 'Grupo1-TP-Final'!
FilterPermisson subclass: #FilterWritePermission
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterWritePermission methodsFor: 'testing' stamp: 'dk 12/7/2021 18:53:58'!
puedeFiltrar: unArchivo 

	 ^ (unArchivo tienePermisosDeEscrituraDelUsuario: usuarioAFiltrar) .! !


!classDefinition: #FilterText category: 'Grupo1-TP-Final'!
Filter subclass: #FilterText
	instanceVariableNames: 'texto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterText methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:04:13'!
initializeConElTexto: unTexto 

	texto _ unTexto.! !


!FilterText methodsFor: 'testing' stamp: 'dk 12/7/2021 16:04:09'!
puedeFiltrar: unArchivo 

	^ (unArchivo texto  = texto).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterText class' category: 'Grupo1-TP-Final'!
FilterText class
	instanceVariableNames: ''!

!FilterText class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:54:45'!
conElTexto: unTexto 

	^ self new initializeConElTexto: unTexto ! !


!classDefinition: #FilterUser category: 'Grupo1-TP-Final'!
Filter subclass: #FilterUser
	instanceVariableNames: 'usuario'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!FilterUser methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:04:17'!
initializeConElUsuario: unUsuario 

	usuario _ unUsuario.! !


!FilterUser methodsFor: 'testing' stamp: 'dk 12/7/2021 16:04:20'!
puedeFiltrar: unArchivo

	^ unArchivo creadoPorUsuario nombre = usuario nombre.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilterUser class' category: 'Grupo1-TP-Final'!
FilterUser class
	instanceVariableNames: ''!

!FilterUser class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:54:49'!
conElUsuario: unUsuario

	^ self new initializeConElUsuario: unUsuario. ! !


!classDefinition: #Handler category: 'Grupo1-TP-Final'!
Object subclass: #Handler
	instanceVariableNames: 'usuarioLogueado unUsuario_CHANGE_ME'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 15:32:22'!
validarSiEl: unUsuario tienePermisosDeEjecucionEn: unArchivo

	((unArchivo tienePermisosDeEjecucionDelUsuario: unUsuario) 
	| (unUsuario esRoot)
	| (usuarioLogueado noEsPropietarioDe: unArchivo) )
		ifTrue:[self error: Terminal errorUsuarioYaTienePermisosDeEjecucion].! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 15:38:43'!
validarSiEl: unUsuario tienePermisosDeEscrituraEn: unArchivo

	((unArchivo tienePermisosDeEscrituraDelUsuario: unUsuario) 
	| (unUsuario esRoot)
	| (usuarioLogueado noEsPropietarioDe: unArchivo) )
		ifTrue:[self error: Terminal errorUsuarioYaTienePermisosDeEscritura].! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 15:42:18'!
validarSiEl: unUsuario tienePermisosDeLecturaEn: unArchivo

	((unArchivo tienePermisosDeLecturaDelUsuario: unUsuario) 
	| (unUsuario esRoot)
	| (usuarioLogueado noEsPropietarioDe: unArchivo) )
		ifTrue:[self error: Terminal errorUsuarioYaTienePermisosDeLectura].! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 15:44:11'!
validarSiEl: unUsuario tienePermisosDeLecturaEnLaCarpeta: unaCarpeta

	((unaCarpeta tienePermisosDeLecturaDelUsuario: unUsuario) 
	| (unaCarpeta creadoPorUsuario nombreEsIgual: (unUsuario nombre))
	| (unUsuario esRoot)
	| (usuarioLogueado noEsPropietarioDe: unaCarpeta) )
		ifTrue:[self error: Terminal errorUsuarioYaTienePermisosDeLectura].! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 15:59:53'!
validarSiElArchivoPuedeSerEjecutadoPorElUsuarioLogueado: unArchivo

	((unArchivo tienePermisosDeEjecucionDelUsuario: usuarioLogueado)
	| (usuarioLogueado esRoot)
	| (unArchivo esCreadoPor: usuarioLogueado))
		ifFalse:[self error: Terminal errorUsuarioSinPermisosDeEjecucion].
		
		! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 16:22:46'!
validarSiElArchivoPuedeSerEscritoPorElUsuarioLogueado: unArchivo

	((unArchivo tienePermisosDeEscrituraDelUsuario: usuarioLogueado)
	| (usuarioLogueado esRoot)
	| (unArchivo esCreadoPor: usuarioLogueado))
		ifFalse:[self error: Terminal errorUsuarioSinPermisosDeEscritura].
		
		! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 15:50:34'!
validarSiElArchivoPuedeSerLeidoPorElUsuarioLogueado: unArchivo

	((unArchivo tienePermisosDeLecturaDelUsuario: usuarioLogueado)
	| (usuarioLogueado esRoot)
	| (unArchivo esCreadoPor: usuarioLogueado))
		ifFalse:[self error: Terminal errorUsuarioSinPermisosDeLectura].
		
		! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 16:28:59'!
validarSiElUsuarioPublico: unUsuario tienePermisosDeEjecucionEn: unArchivo

	((unArchivo tienePermisosDeEjecucionDelUsuario: unUsuario) 
	& (unUsuario esPublico)
	& (unUsuario noEsPropietarioDe: unArchivo) )
		ifFalse: [self error: Terminal errorUsuarioNoTienePermisosDeEjecucion].! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 16:30:39'!
validarSiElUsuarioPublico: unUsuario tienePermisosDeEscrituraEn: unArchivo

	((unArchivo tienePermisosDeEscrituraDelUsuario: unUsuario) 
	& (unUsuario esPublico)
	& (unUsuario noEsPropietarioDe: unArchivo) )
		ifFalse: [self error: Terminal errorUsuarioNoTienePermisosDeEscritura].! !

!Handler methodsFor: 'as yet unclassified' stamp: 'dk 12/8/2021 16:31:47'!
validarSiElUsuarioPublico: unUsuario tienePermisosDeLecturaEn: unArchivo

	((unArchivo tienePermisosDeLecturaDelUsuario: unUsuario) 
	& (unUsuario esPublico)
	& (unUsuario noEsPropietarioDe: unArchivo) )
		ifFalse: [self error: Terminal errorUsuarioNoTienePermisosDeLectura].! !


!Handler methodsFor: 'initialization' stamp: 'dk 12/8/2021 15:33:24'!
initializeConUsuarioLogueado: unUsuario
	usuarioLogueado _ unUsuario.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Handler class' category: 'Grupo1-TP-Final'!
Handler class
	instanceVariableNames: ''!

!Handler class methodsFor: 'instance creation' stamp: 'dk 12/8/2021 15:32:46'!
conUsuarioLogueado: unUsuario
	^self new initializeConUsuarioLogueado: unUsuario ! !


!classDefinition: #Permission category: 'Grupo1-TP-Final'!
Object subclass: #Permission
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Permission methodsFor: 'sub class message' stamp: 'dk 12/7/2021 23:28:35'!
agregar: unUsuario

	self subclassResponsibility .! !

!Permission methodsFor: 'sub class message' stamp: 'dk 12/7/2021 16:04:49'!
printOn: unStream

	self subclassResponsibility .
	! !

!Permission methodsFor: 'sub class message' stamp: 'dk 12/7/2021 23:28:39'!
sacar: unUsuario

	self subclassResponsibility .! !

!Permission methodsFor: 'sub class message' stamp: 'dk 12/7/2021 23:28:43'!
tienePermisos: unUsuario

	self subclassResponsibility .! !


!classDefinition: #ExecutePermission category: 'Grupo1-TP-Final'!
Permission subclass: #ExecutePermission
	instanceVariableNames: 'usuariosQuePuedenEjecutar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!ExecutePermission methodsFor: 'testing' stamp: 'dk 12/7/2021 16:04:57'!
tienePermisos: unUsuario 

	^ usuariosQuePuedenEjecutar anySatisfy: [:unUsuarioEnLaLista | unUsuario nombreEsIgual: unUsuarioEnLaLista nombre]! !


!ExecutePermission methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:05:00'!
initialize

	usuariosQuePuedenEjecutar _ OrderedCollection new .! !


!ExecutePermission methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:05:04'!
agregar: unUsuario 
	
	usuariosQuePuedenEjecutar add: unUsuario ! !

!ExecutePermission methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:37:18'!
sacar: unUsuario 
	
	| usuarioABorrar |
	usuarioABorrar _ usuariosQuePuedenEjecutar detect: [:unUsuarioEnLaLista | unUsuarioEnLaLista nombreEsIgual: unUsuario nombre] .
	
	usuariosQuePuedenEjecutar remove: usuarioABorrar .! !


!ExecutePermission methodsFor: 'printing' stamp: 'dk 12/7/2021 01:33:47'!
printOn: unStream

	usuariosQuePuedenEjecutar do: [:unUsuario | unStream nextPutAll: (unUsuario nombre), ','].! !


!classDefinition: #ReadPermission category: 'Grupo1-TP-Final'!
Permission subclass: #ReadPermission
	instanceVariableNames: 'usuariosQuePuedenLeer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!ReadPermission methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:05:55'!
initialize

	usuariosQuePuedenLeer _ OrderedCollection new .! !


!ReadPermission methodsFor: 'testing' stamp: 'dk 12/7/2021 16:05:50'!
tienePermisos: unUser 

	^ usuariosQuePuedenLeer anySatisfy: [:unUsuarioEnLaLista | unUser nombreEsIgual: unUsuarioEnLaLista nombre]! !


!ReadPermission methodsFor: 'printing' stamp: 'dk 12/7/2021 01:30:40'!
printOn: unStream
	
	usuariosQuePuedenLeer do: [:unUsuario | unStream nextPutAll: (unUsuario nombre), ','].! !


!ReadPermission methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:05:43'!
agregar: unUsuario 
	
	usuariosQuePuedenLeer add: unUsuario ! !

!ReadPermission methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:05:45'!
sacar: unUsuario 
	
	| usuarioABorrar |
	usuarioABorrar _ usuariosQuePuedenLeer detect: [:unUsuarioEnLaLista | unUsuarioEnLaLista nombreEsIgual: unUsuario nombre] .
	
	usuariosQuePuedenLeer remove: usuarioABorrar .! !


!classDefinition: #WritePermission category: 'Grupo1-TP-Final'!
Permission subclass: #WritePermission
	instanceVariableNames: 'usuariosQuePuedenEscribir'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!WritePermission methodsFor: 'testing' stamp: 'dk 12/7/2021 16:05:30'!
tienePermisos: unUsuario 

	^ (usuariosQuePuedenEscribir anySatisfy: [:unUsuarioEnLaLista | unUsuario nombreEsIgual: unUsuarioEnLaLista nombre])! !


!WritePermission methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:05:24'!
initialize

	usuariosQuePuedenEscribir _ OrderedCollection new ! !


!WritePermission methodsFor: 'printing' stamp: 'dk 12/7/2021 16:05:35'!
printOn: unStream

	usuariosQuePuedenEscribir do: [:unUsuario | unStream nextPutAll: (unUsuario nombre), ','].! !


!WritePermission methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:05:16'!
agregar: unUsuario

	usuariosQuePuedenEscribir add: unUsuario.! !

!WritePermission methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:05:19'!
sacar: unUsuario 
	
	| usuarioABorrar |
	usuarioABorrar _ usuariosQuePuedenEscribir detect: [:unUsuarioEnLaLista | unUsuarioEnLaLista nombreEsIgual: unUsuario nombre] .
	
	usuariosQuePuedenEscribir remove: usuarioABorrar .! !


!classDefinition: #Terminal category: 'Grupo1-TP-Final'!
Object subclass: #Terminal
	instanceVariableNames: 'usuarios usuarioLogueado directorioActual directoriosVistos handler'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'initialization' stamp: 'dk 12/8/2021 15:30:46'!
initialize

	| defaultUserRoot |
	defaultUserRoot _ RootUser conNombre: 'root' yContraseña: 'root'.
	usuarios _ Set new .
	usuarios add: defaultUserRoot .	
	
	directorioActual _ Folder conNombre: 'root' .
	directorioActual creadoPor: defaultUserRoot .
	
	directoriosVistos _ OrderedCollection new .
	directoriosVistos add: directorioActual .
	handler _ Handler conUsuarioLogueado: defaultUserRoot .! !

!Terminal methodsFor: 'initialization' stamp: 'dk 12/8/2021 15:31:06'!
initializeIniciarSesion: unUser 

	self iniciarSesion: unUser .
	handler _ Handler conUsuarioLogueado: unUser! !


!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:03'!
esDirectoRaiz

	^ directoriosVistos size = 1! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:06'!
estaParadaEnElDirectorioRaiz

	^ self esDirectoRaiz .! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 23:46:24'!
existeElArchivoEnElDirectorio: unArchivo

	| listaDeArchivosEnElDirectorio |
	listaDeArchivosEnElDirectorio _ directorioActual archivos .

	(listaDeArchivosEnElDirectorio anySatisfy: [:unArchivoEnLaLista| unArchivoEnLaLista nombreEsIgual: unArchivo nombre]) 
		ifTrue:[self error: Terminal errorNoSePuedeCrearUnArchivoConElMismoNombre]! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 19:04:43'!
existeEnElDirectorioActualUnaCarpetaConElMismoNombreA: unaCarpeta

	|carpetasEnElDirectorioActual|
	carpetasEnElDirectorioActual _ directorioActual carpetas.

	 (carpetasEnElDirectorioActual anySatisfy: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista]) 
		ifTrue: [self error: Terminal errorLaCarpetaYaExiste] ! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:13'!
existeEnLaListaDeUsuariosEl: unUser

	^ usuarios anySatisfy: [:unUserEnLaLista | (unUserEnLaLista nombreEsIgual: unUser nombre)]! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:16'!
tieneAlUsuario: unUser 

	^ usuarios anySatisfy: [:unUserEnLaLista | unUserEnLaLista nombreEsIgual: unUser nombre] .! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:19'!
tieneAlUsuarioLogueado: unUsuario 

	^ unUsuario esIgualElUserYContraseñaA: usuarioLogueado! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:22'!
tieneCarpetasEnElDirectorioActual

	^ directorioActual tieneCarpetas.! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:24'!
tieneElArchivoEnElDirectorioActual: unArchivo

	^ (directorioActual archivos) includes: unArchivo.! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/7/2021 16:07:29'!
unaCarpetaNombreEsIgual: unaCarpeta a: carpeta

	^ carpeta nombreEsIgual: (unaCarpeta nombre)! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/8/2021 16:09:12'!
validarSiElUsuarioNoPuedeIniciarSesion: unUser

	^ (usuarios anySatisfy: [:unUserEnLaLista | unUserEnLaLista esIgualElUserYContraseñaA: unUser]) not! !

!Terminal methodsFor: 'testing' stamp: 'dk 12/8/2021 16:21:31'!
validarSiElUsuarioTienePermisosDeEscrituraEnElDirectorio

	( ((directorioActual tienePermisosDeEscrituraDelUsuario: usuarioLogueado) ) 
	| ((directorioActual creadoPorUsuario nombre = usuarioLogueado nombre) & (self esDirectoRaiz) ) 
	| (usuarioLogueado esRoot) )
		ifFalse: [self error: Terminal errorUsuarioSinPermisosDeEscritura].! !


!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:21:03'!
agregarCarpetaEnElDirectorio: unaCarpeta

	unaCarpeta creadoPor: usuarioLogueado .
	^ directorioActual agregarCarpeta: unaCarpeta! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:34:51'!
agregarPermisosDeEjecucion: unUsuario enElArchivo: unArchivo	

	| unArchivoEncontrado unUsuarioEncontrado |
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiEl: unUsuarioEncontrado tienePermisosDeEjecucionEn: unArchivoEncontrado.
	
	usuarioLogueado agregarPermisosParaEjecutar: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:38:56'!
agregarPermisosDeEscritura: unUsuario enElArchivo: unArchivo
	
	| unArchivoEncontrado unUsuarioEncontrado |
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
		
	handler validarSiEl: unUsuarioEncontrado tienePermisosDeEscrituraEn: unArchivoEncontrado.
	
	usuarioLogueado agregarPermisosParaEscribir: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:41:13'!
agregarPermisosDeEscrituraEnElDirectorioPara: unUsuario 

	| unUsuarioEncontrado |
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiEl: unUsuarioEncontrado tienePermisosDeEscrituraEn: directorioActual.
	
	usuarioLogueado agregarPermisosParaEscribir: directorioActual para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:42:36'!
agregarPermisosDeLectura: unUsuario enElArchivo: unArchivo

	| unArchivoEncontrado unUsuarioEncontrado |
	
	unArchivoEncontrado _ self obtenerArchivo: unArchivo .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiEl: unUsuarioEncontrado tienePermisosDeLecturaEn: unArchivoEncontrado.
	
	usuarioLogueado agregarPermisosParaLeer: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:44:13'!
agregarPermisosDeLectura: unUsuario paraLaCarpeta: unaCarpeta 

	|carpetaEncontrada unUsuarioEncontrado |
	
	carpetaEncontrada _ self obtenerCarpeta: unaCarpeta.
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiEl: unUsuarioEncontrado tienePermisosDeLecturaEnLaCarpeta: carpetaEncontrada.
	
	usuarioLogueado agregarPermisosParaLeer: carpetaEncontrada para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:45:36'!
borrarUsuario: unUser 

	(usuarioLogueado nombreEsIgual: (unUser nombre))
		ifTrue: [self error: Terminal errorElUsuarioNoPuedeBorrarse] .
	
	usuarios remove: unUser 
		ifAbsent: [self error: Terminal errorUsuarioInexistente]! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:56:31'!
cd
	
	(self esDirectoRaiz ) 
		ifTrue: [ self error: Terminal errorNoSePuedeVolver ].
	
	self volverUnDirectorio .
		
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:58:47'!
cd: unaCarpeta 
	
	| carpetaSiguiente |
	carpetaSiguiente _ self obtenerCarpeta: unaCarpeta.
	
	handler validarSiElArchivoPuedeSerLeidoPorElUsuarioLogueado: carpetaSiguiente.

	self pasarALaSiguienteCarpeta: carpetaSiguiente .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:00:12'!
ejecutar: unArchivo 
	"Ejecucion en nuestro dominion no hace nada solo devolver el archivo. Solo se fija si existe y el usuario tiene permisos de ejecucion"
	
	| archivoDeEjecucion |
	archivoDeEjecucion _ self obtenerArchivo: unArchivo .
	
	handler validarSiElArchivoPuedeSerEjecutadoPorElUsuarioLogueado: archivoDeEjecucion .
	
	^ archivoDeEjecucion .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:57:09'!
filtrarCon: filtro

	^ (filtro filtrarArchivosEnElDirectorio: directorioActual archivos). ! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:12:29'!
ingresarUsuario: unUserAIngresar
	
	(self existeEnLaListaDeUsuariosEl: unUserAIngresar) 
		ifTrue: [self error: Terminal errorUsuarioIncorrecto] .
	
	usuarios add: unUserAIngresar.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:09:12'!
iniciarSesion: unUserALoguease 
	
	(self validarSiElUsuarioNoPuedeIniciarSesion: unUserALoguease) 
		ifTrue: [
			self error: Terminal errorUsuarioIncorrecto			
		] .
	
	self iniciarSesionConUnNuevoUsuario: unUserALoguease.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:12:44'!
iniciarSesionConUnNuevoUsuario: unUsuarioALoguearse

	usuarioLogueado _ unUsuarioALoguearse .
	handler initializeConUsuarioLogueado: usuarioLogueado .
	directoriosVistos _ OrderedCollection with: (directoriosVistos first).
	directorioActual _ directoriosVistos first.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:21:31'!
mkdir: unaCarpeta

	self existeEnElDirectorioActualUnaCarpetaConElMismoNombreA: unaCarpeta .
	
	self validarSiElUsuarioTienePermisosDeEscrituraEnElDirectorio.
	
	self agregarCarpetaEnElDirectorio: unaCarpeta! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:57:29'!
modificarUsuario: unUserAModificar por: unUserConModificaciones 

	| usuarioEncontrado |
	usuarioEncontrado _ self obtenerUsuario: unUserAModificar .
		
	usuarioEncontrado modificarPor: unUserConModificaciones .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:23:18'!
nano: unArchivo edicion: unTexto
	
	| archivoAModificar |
	archivoAModificar _ self obtenerArchivo: unArchivo .
	
	handler validarSiElArchivoPuedeSerEscritoPorElUsuarioLogueado: archivoAModificar.
		
	archivoAModificar modificarTexto: unTexto .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:58:14'!
pasarALaSiguienteCarpeta: unaCarpeta 
	
	directoriosVistos add: unaCarpeta .
	directorioActual _ (directoriosVistos last) .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:24:39'!
rmArchivo: unArchivoABorrar

	| archivoABorrar |
	archivoABorrar _ self obtenerArchivo: unArchivoABorrar .
	
	handler validarSiElArchivoPuedeSerEscritoPorElUsuarioLogueado: archivoABorrar.
	
	directorioActual archivos remove: archivoABorrar.
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:24:35'!
rmCarpeta: unaCarpetaABorrar

	| carpetaABorrar |
	carpetaABorrar _  self obtenerCarpeta: unaCarpetaABorrar.
	
	handler validarSiElArchivoPuedeSerEscritoPorElUsuarioLogueado: carpetaABorrar.
	
	directorioActual carpetas remove: carpetaABorrar.
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:39:03'!
sacarPermisosDeEjecutarParaElArchivo: unArchivo alUsuario: unUsuario
	
	| unArchivoEncontrado unUsuarioEncontrado |
	unArchivoEncontrado _ self obtenerArchivo: unArchivo .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiElUsuarioPublico: unUsuarioEncontrado tienePermisosDeEjecucionEn: unArchivoEncontrado.
	
	usuarioLogueado sacarPermisosParaEjecutar: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:29:52'!
sacarPermisosDeEscrituraEnElDirectorioPara: unUsuario 

	| unUsuarioEncontrado |
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiElUsuarioPublico: unUsuarioEncontrado tienePermisosDeEscrituraEn: directorioActual.
	
	usuarioLogueado sacarPermisosParaEscribir: directorioActual para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:31:15'!
sacarPermisosDeEscrituraParaElArchivo: unArchivo alUsuario: unUsuario
	
	| unArchivoEncontrado unUsuarioEncontrado |
	unArchivoEncontrado _ self obtenerArchivo: unArchivo .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiElUsuarioPublico: unUsuarioEncontrado tienePermisosDeEscrituraEn: unArchivoEncontrado.
	
	usuarioLogueado sacarPermisosParaEscribir: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:31:59'!
sacarPermisosDeLectura: unUsuario paraLaCarpeta: unaCarpeta
	
	| carpetaEncontrada unUsuarioEncontrado |
	carpetaEncontrada _ self obtenerCarpeta: unaCarpeta.
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiElUsuarioPublico: unUsuarioEncontrado tienePermisosDeLecturaEn: carpetaEncontrada.
	
	usuarioLogueado sacarPermisosParaLeer: carpetaEncontrada para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:32:14'!
sacarPermisosDeLecturaParaElArchivo: unArchivo alUsuario: unUsuario
	
	| unArchivoEncontrado unUsuarioEncontrado |
	unArchivoEncontrado _ self obtenerArchivo: unArchivo .
	unUsuarioEncontrado _ self obtenerUsuario: unUsuario .
	
	handler validarSiElUsuarioPublico: unUsuarioEncontrado tienePermisosDeLecturaEn: unArchivoEncontrado.
	
	usuarioLogueado sacarPermisosParaLeer: unArchivoEncontrado para: unUsuarioEncontrado.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 16:38:45'!
touch: unArchivo
	
	self existeElArchivoEnElDirectorio: unArchivo.
	
	handler validarSiElArchivoPuedeSerEscritoPorElUsuarioLogueado: directorioActual.
	
	unArchivo creadoPor: usuarioLogueado.  
	(directorioActual archivos) add: unArchivo.! !

!Terminal methodsFor: 'public actions' stamp: 'dk 12/8/2021 15:56:15'!
volverUnDirectorio

	directoriosVistos removeLast .
	directorioActual _ directoriosVistos last .	
		
	! !


!Terminal methodsFor: 'accessing' stamp: 'dk 12/8/2021 15:54:26'!
cat: unArchivo 
	
	| archivoDeLectura|
	archivoDeLectura _ self obtenerArchivo: unArchivo .
	
	handler validarSiElArchivoPuedeSerLeidoPorElUsuarioLogueado: unArchivo .
		
	^ archivoDeLectura texto.	 ! !

!Terminal methodsFor: 'accessing' stamp: 'dk 12/7/2021 15:58:30'!
directorioActual
	
	^ directorioActual! !

!Terminal methodsFor: 'accessing' stamp: 'dk 12/7/2021 23:31:17'!
ls

	|archivosYCarpetas|
	archivosYCarpetas _ OrderedCollection new.
	archivosYCarpetas addAll: directorioActual archivos.
	archivosYCarpetas addAll: directorioActual carpetas.
	
	^ archivosYCarpetas.! !

!Terminal methodsFor: 'accessing' stamp: 'dk 12/7/2021 23:35:44'!
obtenerArchivo: unArchivo

	| listaDeCarpetasEnElDirectorioActual |
	listaDeCarpetasEnElDirectorioActual _ directorioActual archivos .

	^ listaDeCarpetasEnElDirectorioActual detect: [:unArchivoEnLaLista | (unArchivoEnLaLista nombreEsIgual: unArchivo nombre)] 
		ifNone: [ self error: Terminal errorElArchivoNoExiste]! !

!Terminal methodsFor: 'accessing' stamp: 'dk 12/7/2021 23:36:24'!
obtenerCarpeta: unaCarpeta

	| listaDeCarpetasEnElDirectorioActual |
	listaDeCarpetasEnElDirectorioActual _ directorioActual carpetas.
	
	^ listaDeCarpetasEnElDirectorioActual detect: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista] 
		ifNone: [self error: Terminal errorLaCarpetaNoExiste] .! !

!Terminal methodsFor: 'accessing' stamp: 'dk 12/7/2021 19:05:47'!
obtenerUsuario: unUsuario

	^ usuarios detect: [:unUsuarioEnLaLista | (unUsuarioEnLaLista nombreEsIgual: unUsuario nombre)] 
		ifNone: [ self error: Terminal errorUsuarioInexistente]! !


!Terminal methodsFor: 'printing' stamp: 'dk 12/7/2021 16:07:57'!
imprimirInfoDelDirectorio
	
	|directorio|
	directorio _ (directorioActual nombre, '.txt') asFileEntry.
	 
	directorio forceWriteStreamDo: [:fileStream | 
		fileStream nextPutAll: (self textoEscritoHastaElMomento)
	].! !

!Terminal methodsFor: 'printing' stamp: 'dk 12/7/2021 16:08:44'!
textoEscritoHastaElMomento
	
	| textoEscritoHastaElMomento |
	textoEscritoHastaElMomento _ String  streamContents: [:unStream | 

		unStream nextPutAll: directorioActual nombre, ':', String newLineString.
			(self ls) do: [:file | 
				file printOn: unStream.
				unStream nextPutAll: String newLineString.
			].
	].
	
	^ textoEscritoHastaElMomento contents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Terminal class' category: 'Grupo1-TP-Final'!
Terminal class
	instanceVariableNames: ''!

!Terminal class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:54:59'!
iniciarSesion: unUser

	^ self new initializeIniciarSesion: unUser ! !


!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:32:21'!
errorCarpetaInexistente
	
	^ 'La carpeta no existe en este directorio'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:46:07'!
errorElArchivoNoExiste
	
	^ 'El archivo no existe'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:42:51'!
errorElUsuarioNoPuedeBorrarse
	
	^ 'El usuario no puede borrarse a el mismo'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:48:02'!
errorLaCarpetaNoExiste
	
	^ 'La carpeta no existe en este directorio'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:32:46'!
errorLaCarpetaYaExiste
	
	^ 'La carpeta ya existe en este directorio'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:46:55'!
errorNoSePuedeCrearUnArchivoConElMismoNombre
	
	^ 'No se puede crear un archivo con el mismo nombre'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:47:19'!
errorNoSePuedeVolver
	
	^ 'No se puede volver, estas parado en root'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:49:10'!
errorUsuarioIncorrecto
	
	^ 'El nombre y/o contraseña es incorrecta' ! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:34:08'!
errorUsuarioInexistente
	
	^ 'El usuario no existe'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:37:58'!
errorUsuarioNoTienePermisosDeEjecucion
	
	^ 'El usuario es root o no tiene permisos de ejecucion sobre este archivo/carpeta'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:35:27'!
errorUsuarioNoTienePermisosDeEscritura
	
	^ 'El usuario es root o no tiene permisos de escritura sobre este archivo/carpeta'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:35:48'!
errorUsuarioNoTienePermisosDeLectura
	
	^ 'El usuario es root o no tiene permisos de lectura sobre este archivo/carpeta'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:39:05'!
errorUsuarioSinPermisosDeEjecucion

	^ 'El usuario no tiene permisos de ejecucion'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:36:23'!
errorUsuarioSinPermisosDeEscritura
	
	^ 'El usuario no tiene permisos de escritura'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:31:30'!
errorUsuarioSinPermisosDeLectura
	
	^ 'El usuario no tiene permisos de lectura'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:34:43'!
errorUsuarioYaTienePermisosDeEjecucion
	
	^ 'El usuario es owner/root o ya tiene permisos de ejecucion sobre este archivo/carpeta'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:41:04'!
errorUsuarioYaTienePermisosDeEscritura
	
	^ 'El usuario es owner/root o ya tiene permisos de escritura sobre este archivo/carpeta'! !

!Terminal class methodsFor: 'accessing' stamp: 'dk 12/7/2021 18:40:21'!
errorUsuarioYaTienePermisosDeLectura
	
	^ 'El usuario es owner/root o ya tiene permisos de lectura sobre este archivo/carpeta'! !


!classDefinition: #User category: 'Grupo1-TP-Final'!
Object subclass: #User
	instanceVariableNames: 'nombre contraseña'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!User methodsFor: 'accessing' stamp: 'dk 12/7/2021 16:09:05'!
contraseña

	^ contraseña! !

!User methodsFor: 'accessing' stamp: 'dk 12/7/2021 16:09:07'!
nombre

	^ nombre! !


!User methodsFor: 'testing' stamp: 'dk 12/7/2021 16:09:11'!
contraseñaEsIgual: unaContraseña 

	^ contraseña = unaContraseña ! !

!User methodsFor: 'testing' stamp: 'dk 12/7/2021 16:09:13'!
esIgualElUserYContraseñaA: unUser 

	^ (self nombreEsIgual: unUser nombre) & (self contraseñaEsIgual: unUser contraseña)! !

!User methodsFor: 'testing' stamp: 'dk 12/7/2021 16:09:15'!
noEsPropietarioDe: unArchivoOCarpeta

	^ unArchivoOCarpeta creadoPorUsuario nombre ~= nombre .! !

!User methodsFor: 'testing' stamp: 'dk 12/7/2021 16:09:17'!
nombreEsIgual: unNombre 

	^ nombre = unNombre ! !


!classDefinition: #PublicUser category: 'Grupo1-TP-Final'!
User subclass: #PublicUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PublicUser methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:00:44'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre _ unNombre.
	contraseña _ unaContraseña.! !


!PublicUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:59:39'!
agregarPermisosParaEjecutar: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEjecutar: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:59:41'!
agregarPermisosParaEscribir: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEscribir: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:59:44'!
agregarPermisosParaLeer: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaLeer: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:01:44'!
modificarPor: unUsuarioConModificaciones 
	
	nombre _ unUsuarioConModificaciones nombre .
	contraseña _ unUsuarioConModificaciones contraseña .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:59:47'!
sacarPermisosParaEjecutar: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEjecutar: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:59:52'!
sacarPermisosParaEscribir: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEscribir: unUsuario .! !

!PublicUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 15:59:55'!
sacarPermisosParaLeer: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaLeer: unUsuario .! !


!PublicUser methodsFor: 'testing' stamp: 'dk 12/7/2021 16:02:25'!
esPublico

	^ true .! !

!PublicUser methodsFor: 'testing' stamp: 'dk 12/7/2021 16:02:23'!
esRoot

	^ false .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublicUser class' category: 'Grupo1-TP-Final'!
PublicUser class
	instanceVariableNames: ''!

!PublicUser class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:55:06'!
conNombre: unNombre yContraseña: unaContraseña

	^ self new initializeConNombre: unNombre yContraseña: unaContraseña ! !


!classDefinition: #RootUser category: 'Grupo1-TP-Final'!
User subclass: #RootUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!RootUser methodsFor: 'initialization' stamp: 'dk 12/7/2021 16:02:37'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre _ unNombre.
	contraseña _ unaContraseña.! !


!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:02'!
agregarPermisosParaEjecutar: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEjecutar: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:05'!
agregarPermisosParaEscribir: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaEscribir: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:08'!
agregarPermisosParaLeer: unArchivo para: unUsuario
	
	unArchivo agregarPermisosParaLeer: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:10'!
borrarUsuario: unUser en: unaTerminal

	unaTerminal borrarUsuario: unUser .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:13'!
modificarUsuario: unUsuario por: unUsuarioConModificaciones en: unaTerminal
 
	unaTerminal modificarUsuario: unUsuario por: unUsuarioConModificaciones .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:15'!
registrarUsuario: unUser en: unaTerminal

	unaTerminal ingresarUsuario: unUser .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:18'!
sacarPermisosParaEjecutar: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEjecutar: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:20'!
sacarPermisosParaEscribir: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaEscribir: unUsuario .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 12/7/2021 16:00:23'!
sacarPermisosParaLeer: unArchivo para: unUsuario 
	
	unArchivo sacarPermisosParaLeer: unUsuario .! !


!RootUser methodsFor: 'testing' stamp: 'dk 12/7/2021 16:00:28'!
esPublico

	^ false .! !

!RootUser methodsFor: 'testing' stamp: 'dk 12/7/2021 16:00:31'!
esRoot

	^ true .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootUser class' category: 'Grupo1-TP-Final'!
RootUser class
	instanceVariableNames: ''!

!RootUser class methodsFor: 'instance creation' stamp: 'dk 12/7/2021 18:55:10'!
conNombre: unNombre yContraseña: unaContraseña 

	^ self new initializeConNombre: unNombre yContraseña: unaContraseña ! !
