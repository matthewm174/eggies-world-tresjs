<script lang="ts" setup>
import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer.js'
import { RenderPass } from 'three/examples/jsm/postprocessing/RenderPass.js'
import { OutputPass } from 'three/examples/jsm/postprocessing/OutputPass.js'
import { HalftonePass } from 'three/examples/jsm/postprocessing/HalftonePass.js'
import { UnrealBloomPass } from 'three-stdlib'
import { extend, useLoop, useTres } from '@tresjs/core'
import { shallowRef } from 'vue'

extend({ EffectComposer, OutputPass, UnrealBloomPass, RenderPass  })
const { renderer, scene, camera, sizes } = useTres()
const composer = shallowRef<EffectComposer>()

useLoop().render(({ elapsed }) => {
  if (composer.value ) {
    composer.value!.render()
  }
})

</script>

<template>
  <TresEffectComposer
    ref="composer"
    :args="[renderer]"
    :set-size="[sizes.width.value, sizes.height.value]"
  >
    <TresRenderPass
      :args="[scene, camera]"
      attach="passes-0"
    />
    <!-- <TresUnrealBloomPass
      :args="[0.8, 0.1, 0.1, 0]"
      attach="passes-1"
    />  -->
    <!-- <TresHalftonePass
    :args="[sizes.width.value, sizes.height.value]"
    attach="passes-2">
    </TresHalftonePass> -->
    <TresOutputPass
      attach="passes-1"
      :set-size="[sizes.width.value, sizes.height.value]"
    />
  </TresEffectComposer>
</template>