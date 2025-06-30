
import { useState } from "react";
import { Sidebar } from "@/components/Sidebar";
import { TutorialContent } from "@/components/TutorialContent";
import { SidebarProvider } from "@/components/ui/sidebar";

const Index = () => {
  const [currentTopic, setCurrentTopic] = useState("introduction");

  return (
    <SidebarProvider>
      <div className="min-h-screen flex w-full bg-gray-50">
        <Sidebar currentTopic={currentTopic} onTopicChange={setCurrentTopic} />
        <main className="flex-1 overflow-auto">
          <TutorialContent currentTopic={currentTopic} />
        </main>
      </div>
    </SidebarProvider>
  );
};

export default Index;
