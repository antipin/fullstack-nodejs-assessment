<template>
    <div>
      <h1>{{ data.title }}</h1>
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">{{ error }}</div>
      <div>
        Price: <strong>{{ data.price }}€</strong>
      </div>
      <p>
        {{ data.description }}
      </p>
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from 'vue';
  import { useRoute } from 'vue-router';
  
  export default {
    name: 'CocktailDetails',
    setup() {
      const data = ref([]);
      const loading = ref(true);
      const error = ref(null);
      const route = useRoute();

      console.log(route.params.id);
      
      const fetchData = async () => {
        try {
          const response = await fetch(`http://localhost:3000/cocktails/${route.params.id}`);
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          const jsonData = await response.json();
          data.value = jsonData;
        } catch (err) {
          error.value = err.message;
        } finally {
          loading.value = false;
        }
      };
  
      onMounted(fetchData);
  
      return {
        data,
        loading,
        error,
      };
    },
  };
  </script>
  
  <style scoped>
  /* Add your styles here */
  </style>