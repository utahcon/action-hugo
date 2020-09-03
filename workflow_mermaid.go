package main

import (
	"fmt"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
	"strings"
)

type EventType string

const (
	CheckRun                 EventType = "check_run"
	CheckSuite               EventType = "check_suite"
	Create                   EventType = "create"
	Delete                   EventType = "delete"
	Deployment               EventType = "deployment"
	DeploymentStatus         EventType = "deployment_status"
	Fork                     EventType = "fork"
	Gollum                   EventType = "gollum"
	IssueComment             EventType = "issue_comment"
	Issues                   EventType = "issues"
	Label                    EventType = "label"
	Milestone                EventType = "milestone"
	PageBuild                EventType = "page_build"
	Project                  EventType = "project"
	ProjectCard              EventType = "project_card"
	ProjectColumn            EventType = "project_column"
	Public                   EventType = "public"
	PullRequest              EventType = "pull_request"
	PullRequestReview        EventType = "pull_request_review"
	PullRequestReviewComment EventType = "pull_request_review_comment"
	PullRequestTarget        EventType = "pull_request_target"
	Push                     EventType = "push"
	RegistryPackage          EventType = "registry_package"
	Release                  EventType = "release"
	RepositoryDispatch       EventType = "repository_dispatch"
	Schedule                 EventType = "schedule"
	Status                   EventType = "status"
	Watch                    EventType = "watch"
	WorkflowRun              EventType = "workflow_run"
	WorkflowDispatch         EventType = "workflow_dispatch"
)

type Event struct {
	eventType EventType
	Types     []string `yaml:"types,omitempty"`
	Schedule  string   `yaml:"schedule,omitempty"`
	Branches  []string `yaml:"branches,omitempty"`
	Workflows []string `yaml:"workflows,omitempty"`
}

type Run struct {
	Shell   string `yaml:"shell"`
	WorkDir string `yaml:"working-directory"`
}

type Default struct {
	Run Run `yaml:"run"`
}

type Step struct {
	Id   string `yaml:"id,omitempty"`
	Name string `yaml:"name,omitempty"`
	Uses string `yaml:"uses",omitempty`
	Run string `yaml:"run,omitempty"`
}

type Job struct {
	Id       string `yaml:",omitempty"`
	Env      map[string]string `yaml:"env,omitempty"`
	Defaults Default           `yaml:"defaults,omitempty"`
	Name     string            `yaml:"name,omitempty"`
	Needs    []string          `yaml:"needs,omitempty"`
	RunsOn   string            `yaml:"runs-on"`
	Steps    []Step            `yaml:"steps"`
	Outputs  map[string]string `yaml:"outputs,omitempty"`
}

type Workflow struct {
	Name     string            `yaml:"name"`
	Events   map[string]Event  `yaml:"on"`
	Env      map[string]string `yaml:"env,omitempty"`
	Defaults map[string]string `yaml:"defaults,omitempty"`
	Jobs     map[string]Job    `yaml:"jobs"`
}

func main() {

	yamlFile, err := ioutil.ReadFile(".github/workflows/build.yml")
	if err != nil {
		log.Printf("yamlFile.Get err #%v", err)
	}
	w := &Workflow{}

	err = yaml.Unmarshal(yamlFile, w)

	var mermaid string
	var mermaidEvents string
	var mermaidJobs string

	// start of doc
	mermaid += "graph TB\n"

	// start of subgraph events
	mermaidEvents += "\tsubgraph events\n"
	for eventType, event := range w.Events {
		event.eventType = EventType(eventType)
		mermaidEvents += fmt.Sprintf("\t\t%s[/%s\\]\n", eventType, eventType)
	}

	jobs := make(map[string]string)
	// start of subgraph jobs
	mermaidJobs += "\t\tsubgraph jobs\n"
	for name, job := range w.Jobs {
		job.Id = name
		var label string
		if job.Name == "" {
			label = job.Id
		} else {
			label = job.Name
		}

		mermaidJobs += fmt.Sprintf("\t\t\tsubgraph job_%s[%q]\n", job.Id, label)

		if job.Needs != nil {
			mermaidJobs += fmt.Sprintf("\t\t\t\t%s_needs>%s]\n", job.Id, strings.Join(job.Needs, "<br>"))
		} else {
			for eventType, event := range w.Events {
				event.eventType = EventType(eventType)
				mermaidEvents += fmt.Sprintf("\t\t%s --> %s_1\n", eventType, job.Id)
			}
		}

		stepCount := 0
		var steps []string
		for _, step := range job.Steps {
			stepCount++

			inside := ""
			switch true {
			case step.Uses != "":
				inside = step.Uses
				break
			case step.Name != "":
				inside = step.Name
				break
			case step.Id != "":
				inside = step.Id
				break
			case step.Run != "":
				inside = step.Run
				break
			}
			steps = append(steps, fmt.Sprintf("%s_%d", job.Id, stepCount))
			mermaidJobs += fmt.Sprintf("\t\t\t\t%s_%d[%q]\n", job.Id, stepCount, inside)
		}

		var currentStep string
		var previousStep string
		for _, step := range steps {
			currentStep = step
			if previousStep != "" {
				mermaidJobs += fmt.Sprintf("\t\t\t\t%s --> %s\n", previousStep, currentStep)
			} else {
				if job.Needs != nil {
					mermaidJobs += fmt.Sprintf("\t\t\t\t%s_needs --> %s\n", job.Id, currentStep)
				}
			}
			previousStep = currentStep
		}

		var outputs string
		if job.Outputs != nil {
			for key, _ := range job.Outputs {
				outputs = strings.Join(append(strings.Split(outputs, "<br>"), key), "<br>")
			}
			mermaidJobs += fmt.Sprintf("\t\t\t\t%s_output{{%s}}\n", job.Id, outputs)
		}
		for key,_ := range job.Outputs {
			mermaid += fmt.Sprintf("\t\t\t\t%s_output{{%s}}\n", job.Id, key)
			if previousStep != "" {
				mermaidJobs += fmt.Sprintf("\t\t\t\t%s --> %s_output\n", previousStep, job.Id)
			}
		}
		mermaidJobs += "\t\t\tend\n"
	}
	// end of jobs
	mermaidJobs += "\t\tend\n"
	mermaidEvents += mermaidJobs

	// end of events
	mermaidEvents += "\tend\n"
	mermaid += mermaidEvents

	// write it to the file
	ioutil.WriteFile("build_test.mermaid", []byte(mermaid), 0644)
	fmt.Printf("Mermaid: \n\n%v\n", mermaid)
}