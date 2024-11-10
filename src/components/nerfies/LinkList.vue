<template>
  <section class="hero">
    <div class="hero-body">
      <div class="container is-max-desktop">
        <div class="columns is-centered">
          <div class="column has-text-centered">
            <div class="publication-links">
              <slot></slot>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>

</script>

<style scoped>
.hero-body {
  padding-top: 24px;
  padding-bottom: 0;
}
</style>
