<template>
  <div>
    <form @submit.prevent="submitForm">
      <span v-if="errors.global" class="message message--type_error">{{ errors.global }}</span>
      <span v-if="successMessage" class="message message--type_success">{{ this.successMessage }}</span>
      <div>
        <label for="title">Title:</label>
        <input type="text" v-model="form.title" id="title">
        <span v-if="errors.fields.title" class="field-error">{{ errors.fields.title }}</span>
      </div>
      <div>
        <label for="price">Price:</label>
        <input type="number" v-model="form.price" id="price">
        <span v-if="errors.fields.price" class="field-error">{{ errors.fields.price }}</span>
      </div>
      <div>
        <label for="description">Description:</label>
        <textarea v-model="form.description" id="description"></textarea>
        <span v-if="errors.fields.description" class="field-error">{{ errors.fields.description }}</span>
      </div>
      <button type="submit">Submit</button>
    </form>
  </div>
</template>

<script>
export default {
  name: 'ListCocktail',
  data() {
    return {
      form: {
        title: '',
        price: '',
        description: ''
      },
      successMessage: '',
      errors: {
        // For global errors
        global: null,
        // For field-specific errors
        fields: {},
      },
    };
  },
  methods: {
    async submitForm() {

      // Reset errors
      this.errors = {
        global: null,
        fields: {},
      };
      this.successMessage = '';

      try {
        const response = await fetch('http://localhost:3000/cocktails', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(this.form)
        });

        if (response.ok) {
          const data = await response.json();
          // Clear the form
          this.form.title = '';
          this.form.price = '';
          this.form.description = '';
          // Set success message
          this.successMessage = `Cocktail "${this.form.title}" succesfully added`;
        } else {
          const errorData = await response.json();
          // Handle global error
          if (errorData.statusCode && errorData.message && typeof errorData.message === 'string') {
            this.errors.global = errorData.message;
          }
          // Handle field-specific errors
          if (Array.isArray(errorData.message)) {
            errorData.message.forEach((fieldError) => {
              const field = fieldError.field;
              const errors = fieldError.errors;
              if (field && errors && errors.length > 0) {
                this.errors.fields[field] = errors.join(', ');
              }
            });
          }
        }
      } catch (error) {
        this.errors.global = error.message;
      }
    }
  }
};
</script>

<style scoped>
/* Optional: Add some basic styling */
form {
  max-width: 400px;
  margin: 0 auto;
}
div {
  margin-bottom: 10px;
}
label {
  display: block;
  margin-bottom: 5px;
}
input, textarea {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}
button {
  padding: 10px 15px;
  background-color: #007bff;
  color: white;
  border: none;
  cursor: pointer;
}
button:hover {
  background-color: #0056b3;
}
.message {
  display: block;
  padding: .75rem 1rem;
  margin-bottom: .75rem;
}
.message--type_success {
  color: #155724;
  background-color: #d4edda;
  border-color: #c3e6cb;
}
.message--type_error {
  color: #721c24;
  background-color: #f8d7da;
  border-color: #f5c6cb;
}
.field-error {
  display: block;
  text-transform: capitalize;
  color: #ea0117;
  padding: .25rem 0 .75rem;
}
</style>