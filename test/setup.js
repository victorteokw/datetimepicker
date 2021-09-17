import {NativeModules} from 'react-native';
NativeModules.RBDatetimePickerManager = {};

NativeModules.RBDatetimePickerManager.getDefaultDisplayValue = jest.fn(() =>
  Promise.resolve({
    determinedDisplayValue: 'spinner',
  }),
);
