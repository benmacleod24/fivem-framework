declare namespace State {
	interface Root {
		application: string;
		isDebug: boolean;
		character: Character;
	}

	interface SetApplication {
		type: 'SET_APPLICATION';
		payload: string;
	}

	interface SetCharacter {
		type: 'SET_CHARACTER';
		payload: Character;
	}

	type RootActions = SetApplication | SetCharacter;
}
