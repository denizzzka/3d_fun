project(
    '3d_fun',
    'd',
    version : '0.1',
    default_options: ['warning_level=3']
)

subdir('JoltPhysicsD')

dagon_dep = dependency('dagon', method: 'dub', version : '>=0.20.0')

exe = executable(
    '3d_fun',
    'source/app.d',
    dependencies: [
        jolt_physics_dep,
        dagon_dep,
    ],
    install: true
)

test('basic', exe)
