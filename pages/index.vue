<script setup lang="ts">
import { AudioLoader, Audio, AudioListener } from 'three';

useControls('fpsgraph')
useControls({
  musicBtn: {
    label: 'Play Music!',
    type: 'button',
    onClick: () => {
      const listener = new AudioListener();
      const sound = new Audio( listener );

      camera.value.add( listener );
      const audioLoader = new AudioLoader();
      
      audioLoader.load( '/music/eggie.mp3', function( buffer ) {
        sound.setBuffer( buffer );
        sound.setLoop( true );
        sound.setVolume( 0.5 );
        sound.play();
      });
    },
    size: 'sm',
  },
})
const camera = shallowRef()

watch(camera, (newVal)=>{
    if(camera.value){
      

    }
});
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