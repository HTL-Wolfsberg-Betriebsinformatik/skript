import { defineAppSetup } from '@slidev/types'
import { Icon } from '@iconify/vue'

export default defineAppSetup(({ app }) => {
  app.component('Icon', Icon)
})