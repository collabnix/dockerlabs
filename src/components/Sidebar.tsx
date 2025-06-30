
import { useState } from "react";
import { ChevronRight, ChevronDown, Book, Terminal, Layers, Network, Shield, Cloud, Wrench, PlayCircle } from "lucide-react";
import { cn } from "@/lib/utils";

interface SidebarProps {
  currentTopic: string;
  onTopicChange: (topic: string) => void;
}

const tutorialSections = [
  {
    title: "Getting Started",
    icon: PlayCircle,
    items: [
      { id: "introduction", title: "What is Docker?", completed: false },
      { id: "installation", title: "Installation", completed: false },
      { id: "first-container", title: "Your First Container", completed: false },
    ]
  },
  {
    title: "Docker Basics",
    icon: Book,
    items: [
      { id: "images-containers", title: "Images & Containers", completed: false },
      { id: "dockerfile", title: "Writing Dockerfiles", completed: false },
      { id: "docker-commands", title: "Essential Commands", completed: false },
    ]
  },
  {
    title: "Intermediate",
    icon: Layers,
    items: [
      { id: "volumes", title: "Volumes & Data", completed: false },
      { id: "networking", title: "Docker Networking", completed: false },
      { id: "multi-stage", title: "Multi-stage Builds", completed: false },
    ]
  },
  {
    title: "Advanced Topics",
    icon: Terminal,
    items: [
      { id: "docker-compose", title: "Docker Compose", completed: false },
      { id: "orchestration", title: "Container Orchestration", completed: false },
      { id: "security", title: "Security Best Practices", completed: false },
    ]
  },
  {
    title: "Production",
    icon: Cloud,
    items: [
      { id: "deployment", title: "Production Deployment", completed: false },
      { id: "monitoring", title: "Monitoring & Logging", completed: false },
      { id: "scaling", title: "Scaling Applications", completed: false },
    ]
  }
];

export function Sidebar({ currentTopic, onTopicChange }: SidebarProps) {
  const [expandedSections, setExpandedSections] = useState<string[]>(["Getting Started", "Docker Basics"]);

  const toggleSection = (sectionTitle: string) => {
    setExpandedSections(prev => 
      prev.includes(sectionTitle) 
        ? prev.filter(s => s !== sectionTitle)
        : [...prev, sectionTitle]
    );
  };

  return (
    <div className="w-80 bg-white border-r border-gray-200 h-screen overflow-auto">
      {/* Header */}
      <div className="p-6 border-b border-gray-200">
        <div className="flex items-center space-x-3">
          <div className="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
            <Terminal className="w-6 h-6 text-white" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-gray-900">Docker Labs</h1>
            <p className="text-sm text-gray-600">Learn Docker Step by Step</p>
          </div>
        </div>
      </div>

      {/* Progress Bar */}
      <div className="p-6 border-b border-gray-100">
        <div className="flex justify-between items-center mb-2">
          <span className="text-sm font-medium text-gray-700">Progress</span>
          <span className="text-sm text-gray-500">2/18 completed</span>
        </div>
        <div className="w-full bg-gray-200 rounded-full h-2">
          <div className="bg-blue-600 h-2 rounded-full transition-all duration-300" style={{ width: '11%' }}></div>
        </div>
      </div>

      {/* Navigation */}
      <nav className="p-4">
        {tutorialSections.map((section) => {
          const isExpanded = expandedSections.includes(section.title);
          const Icon = section.icon;
          
          return (
            <div key={section.title} className="mb-4">
              <button
                onClick={() => toggleSection(section.title)}
                className="w-full flex items-center justify-between p-3 text-left hover:bg-gray-50 rounded-lg transition-colors"
              >
                <div className="flex items-center space-x-3">
                  <Icon className="w-5 h-5 text-gray-600" />
                  <span className="font-medium text-gray-900">{section.title}</span>
                </div>
                {isExpanded ? (
                  <ChevronDown className="w-4 h-4 text-gray-500" />
                ) : (
                  <ChevronRight className="w-4 h-4 text-gray-500" />
                )}
              </button>
              
              {isExpanded && (
                <div className="ml-8 mt-2 space-y-1">
                  {section.items.map((item) => (
                    <button
                      key={item.id}
                      onClick={() => onTopicChange(item.id)}
                      className={cn(
                        "w-full text-left p-3 rounded-lg transition-colors flex items-center space-x-3",
                        currentTopic === item.id
                          ? "bg-blue-50 text-blue-700 border-l-4 border-blue-600"
                          : "hover:bg-gray-50 text-gray-700"
                      )}
                    >
                      <div className={cn(
                        "w-2 h-2 rounded-full",
                        item.completed ? "bg-green-500" : "bg-gray-300"
                      )} />
                      <span className="text-sm">{item.title}</span>
                    </button>
                  ))}
                </div>
              )}
            </div>
          );
        })}
      </nav>
    </div>
  );
}
