<script setup lang="ts">
import { MeshToonMaterial, Vector2 } from 'three'
import { useWindowSize } from '@vueuse/core'


const { width, height } = useWindowSize()
import vertexShader from '../shaders/sphere/vertex.glsl'
import fragmentShader from '../shaders/sphere/fragment.glsl'
import crossShader from '../shaders/cross/fragment.glsl'

const matcapTexture = await useTexture([
  '/textures/PUG.jpg',
]);


useControls('fpsgraph')
const geometryRef = shallowRef(null)
const eggieRef = shallowRef(null)
const textRef = shallowRef(null)
const backgroundRef = shallowRef(null)
const sphere = shallowRef(null)

const sphereUniforms = {
    u_time: { value: 0 },
    u_amplitude: { value: new Vector2(102, 1) },
    u_frequency: { value: new Vector2(1000, 1) },
    u_flip_a: {value: false},
    u_flip_b: {value: true},
    u_flip_c: {value: false}
}


const crossShaderUniforms = {
    fragCoord: { value: new Vector2(0.2, 0.2) }, //vec2
    u_resolution: { value: new Vector2(width.value, height.value) },
    u_time: { value: 0 }
}

// const fontOptions = {
//   size: 0.5,
//   height: 0.2,
//   curveSegments: 5,
//   bevelEnabled: true,
//   bevelThickness: 0.05,
//   bevelSize: 0.02,
//   bevelOffset: 0,
//   bevelSegments: 4,
// }

const videoPath = '/textures/pugdance.mp4'
const pugVideoTexture = ref()
pugVideoTexture.value = await useVideoTexture(videoPath, { loop: true })


// watch(geometryRef, (newVal)=>{
//     if(geometryRef.value){
//         // let t = new MeshToonMaterial()
//         // t.map = pugVideoTexture.value
//         // console.log("GUH")
//         //     console.log(geometryRef)
//         // geometryRef.value.material=t
//         // geometryRef.value.scale.x = -1 // flip normal
//     }
// });


const { onLoop } = useRenderLoop()


onLoop(({ elapsed }) => {
    if (geometryRef.value) {
        geometryRef.value.material.uniforms.u_time.value = elapsed
    }

    if (backgroundRef.value) {
        backgroundRef.value.material.uniforms.u_time.value = elapsed
    }

    if (textRef.value) {
        // console.log("text")
        // console.log(textRef.value.instance.rotation.x)
        textRef.value.instance.rotation.x = elapsed/2.0
        textRef.value.instance.rotation.y = elapsed/2.0
        textRef.value.instance.position.x =  (-Math.cos(elapsed*10)) + 2
        
    }
})
</script>

<template>
    <!-- <OrbitControls /> -->
    <Text3D
    
        :position="[6, 0, 0]"
        :rotation="[0, Math.PI / 2, 0]"
        ref="textRef"
        font="https://raw.githubusercontent.com/Tresjs/assets/main/fonts/FiraCodeRegular.json"
        >
        EGGIE BEAT IMHA
        <TresMeshMatcapMaterial :matcap="matcapTexture" />
    </Text3D>
    <TresMesh ref="geometryRef" :position="[0, 0, 0]" :rotation="[0, -Math.PI / 2, 0]" >
        <TresSphereGeometry :args="[10, 10, 1]" ref="sphere" />
        <TresShaderMaterial :vertex-shader="vertexShader" :fragment-shader="fragmentShader" :uniforms="sphereUniforms" />
    </TresMesh>

    <Edgar ref="eggieRef">
    </Edgar>

    <TresMesh :rotation="[0, Math.PI / 2, 0]" :position="[-1, 0, 0]" ref="backgroundRef">
        <TresPlaneGeometry :args="[10000, 10000]" />
        <TresShaderMaterial :fragment-shader="crossShader" :uniforms="crossShaderUniforms"  />
    </TresMesh>
    <TresAmbientLight :color="0xffffff" :intensity="1" />
    <TresSpotLight :color="0xffffff" :intensity="100" :position="[0, 1, 5]" />
    <TresDirectionalLight :color="0xffffff" :intensity="5" />
    <TresHemisphereLight />
    <PostProcessing />
</template>