<script setup lang="ts">
import { TextureLoader} from 'three'
import { MeshToonMaterial } from 'three/src/materials/MeshToonMaterial';
const { scene, nodes, animations } = await useGLTF('/models/Dancing.glb', { draco: true })
const videoPath = '/textures/pugdance.mp4'
const pugVideoTexture = ref()
pugVideoTexture.value = await useVideoTexture(videoPath, { loop: true })


// const pugText = ref()
const pugImgTexture = await useTexture({map:'/textures/PUG.jpg' , alphaMap: '/textures/PUG.jpg', normalMap: '/textures/PUG.jpg'})


const { actions, mixer } = useAnimations(animations, scene)
console.log(nodes)

//robe
if(nodes['defaultMaterial'].material){
  // let t = new MeshToonMaterial()
  // t.map = pugVideoTexture.value
  // t.normalMap= pugImgTexture.normalMap

  // console.log(t)
  // nodes['defaultMaterial'].material=t
  // nodes['defaultMaterial'].scale.x = -1 // flip normal
}

//eyes


// if(nodes['Shar_Pei_Shar_Pei_0'].material){

//   nodes['Shar_Pei_Shar_Pei_0'].material.color = {isColor: true, r: 0.0, g: 0.2, b: 0.0}

// }
// console.log(actions['Armature|mixamo.com|Layer0'])
let currentAction = actions['Armature|mixamo.com|Layer0']
currentAction.play()
scene.translateX(6)
scene.translateY(-2)

scene.scale.x = -1
const { onLoop } = useRenderLoop()

onLoop(({ elapsed }) => {
  scene.translateX(-Math.sin(elapsed*10)/40)
  if(nodes['Shar_Pei_Shar_Pei_0'].material){

    nodes['Shar_Pei_Shar_Pei_0'].material.color = {isColor: true, r: Math.sin(elapsed/2)/4, g: Math.tan(elapsed/2)/2, b: Math.cos(elapsed/2)/4}

  }
  if(nodes['Shar_Pei_Shar_Pei16_0'].material){
    nodes['Shar_Pei_Shar_Pei16_0'].material.color = {isColor: true, r: Math.tan(elapsed), g: Math.sin(elapsed/2)/2, b: 0.2}
  }

  if(nodes['Shar_Pei_Shar_Pei18_0'].material){
    nodes['Shar_Pei_Shar_Pei18_0'].material.color = {isColor: true, r: Math.sin(elapsed)/2, g: Math.sin(elapsed)/2, b: Math.sin(elapsed)/2}
  }
  if(nodes['defaultMaterial'].material){
    nodes['defaultMaterial'].material.color = {isColor: true, r: Math.sin(elapsed)/2, g: Math.sin(elapsed)/2, b: Math.sin(elapsed)/2}
  }
})
</script>

<template>
      <primitive :object="scene">
        <!-- <TresMeshBasicMaterial :map="texture" /> -->
      </primitive>
</template>