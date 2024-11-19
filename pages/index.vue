<script setup lang="ts">
useControls('fpsgraph')
const camera = shallowRef()



// watch(cameraRef, (newVal)=>{
//   if(cameraRef){
//     console.log(cameraRef.value)
//   }
// });

</script>

<template>
  <TresLeches />
  <TresCanvas
    window-size
    class="over-hidden">
    <TresPerspectiveCamera ref="camera" :near="0.01" :far="20000" :position="[10,0,0]" :rotation="[0, Math.PI / 2, 0]"
     />
  <Suspense>
    <TresGroup>
      <World/>
    </TresGroup>
  </Suspense>
  </TresCanvas>
</template>