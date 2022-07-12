local dap = require('dap')

dap.adapters.dart = {
  type = "executable",
  command = "node",
  args = { os.getenv('HOME') .. "/.local/share/Dart-Code/out/dist/debug.js", "flutter" }
}
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = os.getenv('FLUTTER_HOME') .. "/bin/cache/dart-sdk/",
    flutterSdkPath = os.getenv('FLUTTER_HOME'),
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  }
}
dap.adapters.dart = dap.adapters.dart
dap.configurations.dart = dap.configurations.dart
