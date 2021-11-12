!classDefinition: #TerminalTest category: 'Grupo1-TP-Final'!
TestCase subclass: #TerminalTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/12/2021 01:00:40'!
test001_cuandoUnaTerminalSeCrea_tieneUnUsuarioLogueado

	"Setup"
	| terminal unUsuarioLogueado |
	unUsuarioLogueado _ UserRoot conNombre: 'Diego' yContraseña: '1234' .
	terminal _ Terminal new .
	terminal agregarUsuario: unUsuarioLogueado . "La terminal se ocupa de agregarUnUsuario?? O el usuario Root??"
	
	"Exercise"
	terminal iniciarSesion: unUsuarioLogueado .
	
	Assert isTrue: terminal tieneUnUsuarioLogueado .! !


!classDefinition: #UsersTest category: 'Grupo1-TP-Final'!
TestCase subclass: #UsersTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!UsersTest methodsFor: 'testing_users' stamp: 'dk 11/12/2021 00:48:20'!
test001_cuandoUnUsuarioPublicoSeCrea_esteTieneUnNombreYUnaContraseña

	| userPublic |
	userPublic _ UserPublic conNombre: 'Diego' yContraseña: '1234' .

	Assert that: userPublic nombre isEqualTo: 'Diego' .
	Assert that: userPublic contraseña isEqualTo: '1234' .! !

!UsersTest methodsFor: 'testing_users' stamp: 'dk 11/12/2021 00:52:03'!
test002_cuandoUnUsuarioRootSeCrea_esteTieneUnNombreYUnaContraseña

	| userRoot |
	userRoot _ UserRoot conNombre: 'Diego' yContraseña: '1234' .

	Assert that: userRoot nombre isEqualTo: 'Diego' .
	Assert that: userRoot contraseña isEqualTo: '1234' .! !


!classDefinition: #Terminal category: 'Grupo1-TP-Final'!
Object subclass: #Terminal
	instanceVariableNames: 'listaDeUsuarios usuarioLogueado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'public actions' stamp: 'dk 11/12/2021 01:01:20'!
agregarUsuario: unUsuario 
	listaDeUsuarios add: unUsuario .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/12/2021 01:05:00'!
iniciarSesion: unUsuario 
	usuarioLogueado _ unUsuario  .! !


!Terminal methodsFor: 'initialization' stamp: 'dk 11/12/2021 01:02:46'!
initialize

	listaDeUsuarios _ Set new . ! !


!Terminal methodsFor: 'testing' stamp: 'dk 11/12/2021 01:05:52'!
tieneUnUsuarioLogueado
	^ usuarioLogueado notNil .! !


!classDefinition: #User category: 'Grupo1-TP-Final'!
Object subclass: #User
	instanceVariableNames: 'nombre contraseña'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!User methodsFor: 'accessing' stamp: 'dk 11/12/2021 00:50:55'!
contraseña
	^contraseña! !

!User methodsFor: 'accessing' stamp: 'dk 11/12/2021 00:50:50'!
nombre
	^nombre! !


!classDefinition: #UserPublic category: 'Grupo1-TP-Final'!
User subclass: #UserPublic
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!UserPublic methodsFor: 'initialization' stamp: 'dk 11/12/2021 00:49:04'!
initializeConNombre: unNombre yContraseña: unaContraseña
	nombre := unNombre.
	contraseña := unaContraseña.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UserPublic class' category: 'Grupo1-TP-Final'!
UserPublic class
	instanceVariableNames: ''!

!UserPublic class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 00:48:44'!
conNombre: unNombre yContraseña: unaContraseña
	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !


!classDefinition: #UserRoot category: 'Grupo1-TP-Final'!
User subclass: #UserRoot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!UserRoot methodsFor: 'initialization' stamp: 'dk 11/12/2021 00:45:32'!
initializeConNombre: unNombre yContraseña: unaContraseña 
	nombre := unNombre.
	contraseña := unaContraseña.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UserRoot class' category: 'Grupo1-TP-Final'!
UserRoot class
	instanceVariableNames: ''!

!UserRoot class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 00:45:03'!
conNombre: unNombre yContraseña: unaContraseña 
	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !
