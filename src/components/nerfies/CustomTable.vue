<template>
  <section class="section">
    <div class="container is-max-desktop">
      <div class="columns is-centered has-text-centered">
        <table class="table is-narrow">
          <slot></slot>
        </table>
      </div>
    </div>
  </section>
</template>

<script setup>

</script>

<style scoped>
.section {
  padding-top: 0;
  padding-bottom: 1.5rem;
}
</style>