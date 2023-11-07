import React, { createContext, useContext, Dispatch, useReducer } from 'react';

const initialState: State.Root = {
	application: '',
	isDebug: process.env.NODE_ENV ? true : false,
	character: {
		first_name: 'John',
		last_name: 'Doe',
		netId: 2,
		id: 2,
	},
};

const RootContext = createContext<{
	state: State.Root;
	dispatch: Dispatch<State.RootActions>;
}>({ state: initialState, dispatch: () => null });

const rootReducer = (
	state: State.Root,
	action: State.RootActions
): State.Root => {
	switch (action.type) {
		case 'SET_APPLICATION':
			return {
				...state,
				application: action.payload,
			};
		case 'SET_CHARACTER':
			return {
				...state,
				character: { ...action.payload },
			};
		default:
			return state;
	}
};

export const useRootState = () => useContext(RootContext);

export const RootProvider: React.FC<{ children: React.ReactNode }> = ({
	children,
}) => {
	const [state, dispatch] = useReducer(rootReducer, initialState);

	return (
		<RootContext.Provider value={{ state, dispatch }}>
			{children}
		</RootContext.Provider>
	);
};
