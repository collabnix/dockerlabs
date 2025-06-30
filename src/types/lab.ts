export interface Lab {
  id: string;
  title: string;
  description: string;
  category: 'beginners' | 'intermediate' | 'advanced' | 'networking' | 'security' | 'cloud';
  difficulty: 1 | 2 | 3 | 4 | 5;
  duration: string;
  prerequisites: string[];
  tags: string[];
  author: string;
  lastUpdated: string;
  featured: boolean;
  sections: LabSection[];
  nextLab?: string;
  previousLab?: string;
}

export interface LabSection {
  id: string;
  title: string;
  type: 'text' | 'code' | 'command' | 'warning' | 'info' | 'image';
  content: string;
  language?: string;
  imageUrl?: string;
}
