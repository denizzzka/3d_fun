cmake = import('cmake')

add_languages('cpp', native: true) #fixes WARNING, need to properly process cpp_std value

#TODO: implement:
#Possible build types: Debug (default), Release, Distribution, ReleaseUBSAN, ReleaseASAN, ReleaseTSAN, ReleaseCoverage

#~ vars = cmake.subproject_options()
#~ vars.set_override_option('cpp_std', '11')
jp_proj = cmake.subproject('JoltPhysics')
cpp_dep = jp_proj.dependency(['Jolt'])

jolt_physics_lib = static_library(
    'JoltPhysics',
    dependencies: cpp_dep,
    link_language: 'cpp',
)

jolt_physics_dep = declare_dependency(
    include_directories: '.',
    link_with: [jolt_physics_lib],
)
