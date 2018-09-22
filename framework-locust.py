from locust import HttpLocust, TaskSet, task

class WebsiteTasks(TaskSet):
#    @task
#    def framework(self):
#        self.client.get("/framework")

    @task
    def benchmark(self):
        self.client.get("/benchmark")

        
class WebsiteUser(HttpLocust):
    task_set = WebsiteTasks
    min_wait = 50
    max_wait = 150
    
