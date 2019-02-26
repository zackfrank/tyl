/* global Vue axios*/

new Vue({
  el: '#app',
  data: {
    newTask: null,
    taskAdded: false,
    taskEmpty: false,
    tasks: [],
    tags: [],
    selectedTag: '',
    selectedTags: [],
    filterStatus: false,
    filterList: [], 
    inbox: [],
    showInbox: false,
    showInboxMessage: false,
    selectedTask: null,
    showTagSelector: false,
    showTaskTags: null,
    tagToAdd: '',
    tagsToAdd: [],
    showAddCard: true,
    showCards: false
  },
  created: function() {
    axios.get('/tasks').then(
      function(response) {
        this.tasks = response.data.tasks;
        this.inbox = response.data.inbox;
      }.bind(this)
    );
    axios.get('/tags').then(
      function(response) {
        this.tags = response.data;
        console.log(this.tags);
      }.bind(this)
    );
  },
  methods: {
    displayInbox() {
      if (this.inbox.length > 0) {
        this.showNothing();
        this.showInbox = !this.showInbox;
      } else {
        this.showInboxMessage = true;
        setTimeout(function() {
          this.showInboxMessage = false;
        }.bind(this), 3500);
      }
    },
    displayNewCard() {
      this.showNothing();
      this.showAddCard = true;
    },
    displayCards() {
      this.showNothing();
      this.showCards = true;
    },
    showNothing() {
      this.showCards = false;
      this.showAddCard = false;
      this.showInbox = false;
    },
    chooseTags(task) {
      this.selectedTask = task;
      this.showTagSelector = true;
    },
    markComplete(taskId) {
      var params = {
        completed: true
      };
      axios.patch('/tasks/' + taskId, params).then(
        function(response) {
          this.tasks = response.data.tasks;
          this.inbox = response.data.inbox;
        }.bind(this)
      );
    },
    removeTagFilter(tag) {
      var index = this.selectedTags.indexOf(tag);
      this.selectedTags.splice(index, 1);
    },
    removeTagToAdd(tag) {
      var index = this.tagsToAdd.indexOf(tag);
      this.tagsToAdd.splice(index, 1);
    },
    changeFilterStatus() {
      if (this.filterStatus === false) {
        this.filterStatus = true;
      } else if (this.filterStatus === true) {
        this.filterStatus = null;
      } else if (this.filterStatus === null) {
        this.filterStatus = false;
      }
    },
    taskFiltered(task) {
      return this.filterTags(task) && this.filterCompleted(task);
    },
    filterTags(task) {
      var tagPresent = true;
      if (this.selectedTags.length === 0) {
        return true;
      }
      if (task.tags.length === 0) {
        return false;
      }
      // this can prob be refactored without a forEach .. ?
      this.selectedTags.forEach(function(tag) {
        if (!task.tags.includes(tag.name)) {
          tagPresent = false;
        }
      });
      return tagPresent;
    },
    filterCompleted(task) {
      if (this.filterStatus === null) {
        return true;
      } else if (this.filterStatus === false && task.completed === false) {
        return true;
      } else if (this.filterStatus === true && task.completed === true) {
        return true;
      } else {
        return false;
      }
    },
    showTaskTagsFor(task) {
      if (task === this.showTaskTags) {
        return true;
      }
    },
    triggerShowTaskTags(task) {
      if (this.showTaskTags === task) {
        this.showTaskTags = null;
      } else {
        this.showTaskTags = task;
      }
    },
    addTask() {
      if (this.newTask) {
        var params = {
          name: this.newTask
        };
        axios.post('/tasks', params).then(
          function(response) {
            this.tasks = response.data.tasks;
            this.inbox = response.data.inbox;
            this.newTask = null;
            this.taskAdded = true;
            setTimeout(function() {
              this.taskAdded = false;
            }.bind(this), 10000);
          }.bind(this)
        );
      } else {
        this.taskEmpty = true;
        setTimeout(function() {
          this.taskEmpty = false;
        }.bind(this), 1500);
      }
    },
    clearTags() {
      this.selectedTags = [];
    },
    clearTagsToAdd() {
      this.tagsToAdd = [];
    },
    addTags() {
      var id = this.selectedTask.id;
      var params = {
        tags: this.tagsToAdd
      };
      axios.patch('/tasks/' + id, params).then(
        function(response) {
          this.tasks = response.data.tasks;
          this.inbox = response.data.inbox;
          this.selectedTask = null;
          this.tagsToAdd = [];
        }.bind(this)
      );
    }
  },
  watch: {
    selectedTag(value) {
      if (!this.selectedTags.includes(value) && this.selectedTag !== '') {
        this.selectedTags.push(value);
      }
      this.selectedTag = '' ;
    },
    tagToAdd(value) {
      if (!this.tagsToAdd.includes(value) && this.tagToAdd !== '') {
        this.tagsToAdd.push(value);
      }
      this.tagToAdd = '' ;
    },
    showInbox(value) {
      if (!value) {
        this.showTagSelector = false;
      }
    },
    inbox(value) {
      if (value.length === 0) {
        this.showInbox = false;
      }
    }
  }
});